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

}

public protocol StatusBarViewModelOutput {

    var menuItems: Driver<[NSMenuItem]>! { get }
    var terminalApp: PublishSubject<Void> { get }
}

public final class StatusBarViewModel: StatusBarViewModelType, StatusBarViewModelInput, StatusBarViewModelOutput {

    public var input: StatusBarViewModelInput { return self }
    public var output: StatusBarViewModelOutput { return self }

    // MARK: - Variable
    
    // MARK: - Output
    public var menuItems: Driver<[NSMenuItem]>!
    public var menus = Variable<[Menu]>([Menu(kind: .getFeature, selector: #selector(StatusBarViewModel.getFeatureOnTap), keyEquivalent: "F"),
                                         Menu(kind: .separator, selector: nil),
                                         Menu(kind: .launchOnStartup, selector: #selector(StatusBarViewModel.launchOnStartUp(_:)), defaultState: Setting.shared.isLaunchOnStartup ? .on : .off),
                                         Menu(kind: .separator, selector: nil),
                                         Menu(kind: .quit, selector: #selector(StatusBarViewModel.quitOnTap), keyEquivalent: "Q")])
    public var terminalApp = PublishSubject<Void>()

    // MARK: - Init
    public init() {

        menuItems = menus.asObservable()
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
        .asDriver(onErrorJustReturn: [])
    }

    @objc private func getFeatureOnTap() {
        Coordinator.default.wallpaperService.setFeaturePhotoAction.execute(())
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
        terminalApp.onNext(())
    }
}
