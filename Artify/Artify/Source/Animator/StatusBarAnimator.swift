//
//  StatusBarAnimator.swift
//  Artify
//
//  Created by Nghia Tran on 6/8/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Foundation
import Cocoa

protocol Animator {

    func start()
    func stop()
}

final class StatusBarAnimator: Animator {

    struct Constant {
        static let Interval: TimeInterval = 1 / 2
        static let MaxIndex = 10
    }

    // MARK: - Variable
    private let iconName: String
    private let original: String
    private var timer: Timer?
    private var index: Int = 0
    weak var statusBarBtn: NSStatusBarButton?

    // MARK: - Init
    init(statusBarBtn: NSStatusBarButton, iconName: String, original: String) {
        self.statusBarBtn = statusBarBtn
        self.iconName = iconName
        self.original = original
    }

    func start() {
        invalideTimer()
        timer = Timer.scheduledTimer(timeInterval: Constant.Interval,
                                     target: self,
                                     selector: #selector(self.timerFire),
                                     userInfo: nil,
                                     repeats: true)
    }

    func stop() {
        invalideTimer()
        statusBarBtn?.image = NSImage(named: NSImage.Name(original))
    }

    @objc func timerFire() {

        // Reset if need
        if index >= Constant.MaxIndex {
            index = 0
        }

        // Animate
        let name = "\(iconName)_\(index)"
        let image = NSImage(named: NSImage.Name(name))
        statusBarBtn?.image = image
        index += 1
    }

    private func invalideTimer() {
        timer?.invalidate()
        timer = nil
    }
}
