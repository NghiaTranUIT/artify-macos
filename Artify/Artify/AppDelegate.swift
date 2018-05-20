//
//  AppDelegate.swift
//  Artify
//
//  Created by Nghia Tran on 5/16/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Cocoa
import artify_core
import RxSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Variable
    fileprivate let bag = DisposeBag()
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    fileprivate let viewModel: StatusBarViewModelType = StatusBarViewModel()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        initStatusBarApp()
        binding()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
}

// MARK: - Private
extension AppDelegate {

    fileprivate func initStatusBarApp() {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
    }

    fileprivate func binding() {

        let output = viewModel.output

        // Menu
        output.menus.asObservable()
            .map { (menus) -> [NSMenuItem] in
                return menus.map({ (menu) -> NSMenuItem in
                    return NSMenuItem(title: menu.title, action: menu.selector, keyEquivalent: menu.keyEquivalent)
                })
            }
            .map({ (menuItems) -> NSMenu in
                let menu = NSMenu()
                menuItems.forEach { menu.addItem($0) }
                return menu
            })
            .subscribe(onNext: { (menu) in
                self.statusItem.menu = menu
            })
        .disposed(by: bag)
    }
}

