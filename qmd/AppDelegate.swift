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

        let sb = StatusBar()
        sb.configureStatusBar(statusItem: statusItem) {
            NSApp.activate(ignoringOtherApps: true)
            self.textWindow.makeKeyAndOrderFront(self)
            
        }
        self.statusBar = sb
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}

