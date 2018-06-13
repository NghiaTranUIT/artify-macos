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
        return Coordinator(kind: .sandbox, trackable: FabricTracker())
        #else
        return Coordinator(kind: .production, trackable: FabricTracker())
        #endif
    }()
    fileprivate let bag = DisposeBag()
    fileprivate let appUpdater = SparkleUpdater()
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    fileprivate lazy var viewModel: StatusBarViewModelType = {
        return StatusBarViewModel(updater: self.appUpdater)
    }()
    fileprivate lazy var animator: Animator = StatusBarAnimator(statusBarBtn: self.statusItem.button!,
                                                                iconName: "star_icon_animation",
                                                                original: "StatusBarButtonImage")

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        initApp()
        initStatusBarApp()
        binding()
        setupApp()
        
        // Fetch feature if need
        viewModel.input.getFeatureWallpaperPublisher.onNext(())
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
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
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

        // Animation
        output.isLoading.drive(onNext: {[weak self] (isLoading) in
            print("isLoading = \(isLoading)")
            guard let strongSelf = self else { return }
            if isLoading {
                strongSelf.animator.start()
            } else {
                strongSelf.animator.stop()
            }
        })
        .disposed(by: bag)

        // Open About
        output.openAboutWindow
            .drive(onNext: {[weak self] in
                guard let strongSelf = self else { return }

                // Present modal
                AboutWindowController.presentController(strongSelf)
            })
            .disposed(by: bag)
    }

    fileprivate func setupApp() {

        // Launch on startup if need
        #if !DEBUG
            LaunchOnStartup.setLaunchAtStartup(Setting.shared.isLaunchOnStartup)
        #endif

        // Track
        TrackingService.default.tracking(.openApp)
    }
}

