//
//  AppDelegate.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/28.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var statusBar: StatusBar?
    private var textWindow: TextWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        textWindow = TextWindow()
        textWindow.center()
        
        NSApp.setActivationPolicy(.accessory)

        // アクセシビリティアクセスが有効かどうか
        let accessibilityEnabled = AXIsProcessTrusted()
        
        self.statusBar = StatusBar(statusItem: statusItem, accessibilityEnabled: accessibilityEnabled) {
            NSApp.activate(ignoringOtherApps: true)
            self.textWindow.makeKeyAndOrderFront(self)
        }
        // 常時アクセシビリティアクセスを監視したくないのでNotificationで処理する
        setupAccessibilityNotificationObserver()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    private func setupAccessibilityNotificationObserver() {
        // NSWorkspace.didActivateApplicationNotification はアプリケーションが有効になったときに発生するイベントっぽい
        // 他のどのアプリケーションでも動作するが頻度がそんなに高くなさそうなので、このイベントを利用している
        NSWorkspace.shared.notificationCenter.addObserver(self,
                                                          selector: #selector(handleAccessibilityNotification(_:)),
                                                          name: NSWorkspace.didActivateApplicationNotification,
                                                          object: nil)
    }
    
    @objc private func handleAccessibilityNotification(_ notification: Notification) {
        let accessibilityEnabled = AXIsProcessTrusted()
        self.statusBar?.configureStatusBar(statusItem: self.statusItem, accessibilityEnabled: accessibilityEnabled)
    }
}

