//
//  StatusBarViewModel.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Cocoa
import Moya
import Action

public protocol StatusBarViewModelType {

    var input: StatusBarViewModelInput { get }
    var output: StatusBarViewModelOutput { get }
}

public protocol StatusBarViewModelInput {

    var getFeatureWallpaperPublisher: PublishSubject<Void> { get }
}

public protocol StatusBarViewModelOutput {

    var menuItems: Variable<[NSMenuItem]> { get }
    var terminalApp: PublishSubject<Void> { get }
}

public final class StatusBarViewModel: StatusBarViewModelType, StatusBarViewModelInput, StatusBarViewModelOutput {

    public var input: StatusBarViewModelInput { return self }
    public var output: StatusBarViewModelOutput { return self }

    // MARK: - Variable
    private let bag = DisposeBag()

    // MARK: - Input
    public var getFeatureWallpaperPublisher = PublishSubject<Void>()

    // MARK: - Output
    public let menuItems = Variable<[NSMenuItem]>([])
    public let menus = Variable<[Menu]>([Menu(kind: .getFeature, selector: #selector(StatusBarViewModel.getFeatureOnTap(_:)), keyEquivalent: "F"),
                                         Menu(kind: .separator, selector: nil),
                                         Menu(kind: .launchOnStartup, selector: #selector(StatusBarViewModel.launchOnStartUp(_:)), defaultState: Setting.shared.isLaunchOnStartup ? .on : .off),
                                         Menu(kind: .separator, selector: nil),
                                         Menu(kind: .quit, selector: #selector(StatusBarViewModel.quitOnTap), keyEquivalent: "Q")])
    public let terminalApp = PublishSubject<Void>()

    // MARK: - Init
    public init() {

        // Menu
        menus.asObservable()
            .map {[unowned self] in
                $0.map({ (menu) -> NSMenuItem in
                    if menu.kind == Menu.Kind.separator {
                        return NSMenuItem.separator()
                    }
                    let item = NSMenuItem(title: menu.title,
                                          action: menu.selector,
                                          keyEquivalent: menu.keyEquivalent)
                    item.target = self // Override the target
                    item.state = menu.defaultState
                    return item
                })
            }
            .bind(to: menuItems)
            .disposed(by: bag)

        // Get feature
        getFeatureWallpaperPublisher.asObserver()
            .map { _ in self.menus.value.index(where: { $0.kind == Menu.Kind.getFeature } )! }
            .map { self.menuItems.value[$0] }
            .subscribe(onNext: {[weak self] (menu) in
                guard let strongSelf = self else { return }
                strongSelf.getFeatureOnTap(menu)
            })
            .disposed(by: bag)
    }

    @objc private func getFeatureOnTap(_ menu: NSMenuItem) {
        let action = Coordinator.default.wallpaperService.setFeaturePhotoAction

        // Enable/Disable
        action
            .executing
            .subscribe(onNext: { (isExecuting) in
                menu.isEnabled = !isExecuting
            })
            .disposed(by: bag)

        // Execute
        action.execute(())
    }

    @objc private func launchOnStartUp(_ menu: NSMenuItem) {
        let newState = (menu.state == NSControl.StateValue.on) ? NSControl.StateValue.off : NSControl.StateValue.on
        menu.state = newState

        // Save
        let newValue = newState == .on
        Setting.shared.isLaunchOnStartup = newValue
        LaunchOnStartup.setLaunchAtStartup(newValue)
    }

    @objc private func quitOnTap() {
        Coordinator.default.trackingService.tracking(.exitApp)
        terminalApp.onNext(())
    }
}
