//
//  AboutWindowController.swift
//  Artify
//
//  Created by Nghia Tran on 6/12/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Cocoa

class AboutWindowController: NSWindowController {

    @IBOutlet weak var cell: NSButtonCell!
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.styleMask = NSWindow.StyleMask(rawValue: self.window!.styleMask.rawValue & ~NSWindow.StyleMask.resizable.rawValue)
    }

    @IBAction func nghiaTranBtnOnTap(_ sender: Any) {
        let url = URL(string: "https://nghiatran.me")!
        NSWorkspace.shared.open(url)
    }

    @IBAction func artifyMacOSBtnOnTap(_ sender: Any) {
        print("Hi")
        let url = URL(string: "https://github.com/NghiaTranUIT/artify-macos")!
        NSWorkspace.shared.open(url)
    }

    @IBAction func artifyCoreBtnOnTap(_ sender: Any) {
        let url = URL(string: "https://github.com/NghiaTranUIT/artify-core")!
        NSWorkspace.shared.open(url)
    }
}
