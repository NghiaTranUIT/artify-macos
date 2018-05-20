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
    fileprivate let viewModel = StatusBarViewModel()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        initStatusBarApp()
        binding()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"

        print("\(quoteText) — \(quoteAuthor)")
    }
}

// MARK: - Private
extension AppDelegate {

    fileprivate func initStatusBarApp() {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(printQuote(_:))
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

