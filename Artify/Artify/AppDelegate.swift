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
import Fabric
import Crashlytics

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Variable
    fileprivate lazy var coordinator: Coordinator = {
        #if DEBUG
        return Coordinator(kind: .sandbox)
        #else
        return Coordinator(kind: .production)
        #endif
    }()
    fileprivate let bag = DisposeBag()
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    fileprivate let viewModel = StatusBarViewModel()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        initApp()
        initStatusBarApp()
        binding()

        // Update app
        coordinator.updateAppIfNeed()

        LaunchOnStartup.setLaunchAtStartup(true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
}

// MARK: - Private
extension AppDelegate {

    fileprivate func initApp() {
        coordinator.makeDefaut()
        Fabric.with([Crashlytics.self])
        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
        Crashlytics.sharedInstance().setUserIdentifier(String.macSerialNumber())
        Crashlytics.sharedInstance().setUserName(NSUserName())
    }
    
    fileprivate func initStatusBarApp() {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
    }

    fileprivate func binding() {

        let output = viewModel.output

        // Menu
        output.menuItems.asObservable()
            .map { (menuItems) -> NSMenu in
                let menu = NSMenu()
                menuItems.forEach { menu.addItem($0) }
                return menu
            }
            .subscribe(onNext: {[weak self] (menu) in
                guard let strongSelf = self else { return }
                strongSelf.statusItem.menu = menu
            })
            .disposed(by: bag)

        // Terminal app
        output.terminalApp.subscribe(onNext: { _ in
            NSApplication.shared.terminate(nil)
        })
        .disposed(by: bag)
    }
}

