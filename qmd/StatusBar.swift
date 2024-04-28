//
//  StatusBar.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/28.
//

import Cocoa

class StatusBar: NSObject {
    private var openQmdAction: (() -> Void)?
    
    func configureStatusBar(statusItem: NSStatusItem, openQmdAction: @escaping () -> Void) {
        self.openQmdAction = openQmdAction
        
        let button = statusItem.button!
        button.image = NSImage(systemSymbolName: "star", accessibilityDescription: nil)
                
        let menu = NSMenu()
        let openQmdItem = NSMenuItem(title: "qmdを開く", action: #selector(openQmd), keyEquivalent: "")
        openQmdItem.target = self
        menu.addItem(openQmdItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let settingsItem = NSMenuItem(title: "設定", action: #selector(showSettings), keyEquivalent: ",")
        settingsItem.target = self
        menu.addItem(settingsItem)
        
        let quitItem = NSMenuItem(title: "終了", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    // "qmdを開く" メニューアイテムの処理
    @objc func openQmd() {
        openQmdAction?()
    }
    
    // "設定" メニューアイテムの処理
    @objc func showSettings() {
        
    }
    
    // "終了" メニューアイテムの処理
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
