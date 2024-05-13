//
//  StatusBar.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/28.
//

import Cocoa

class StatusBar: NSObject {
    private var openQmdAction: (() -> Void)
    private var eventMonitor: Any?
    
    init(statusItem: NSStatusItem, accessibilityEnabled: Bool, openQmdAction: @escaping () -> Void) {
        self.openQmdAction = openQmdAction
        
        super.init()
        
        configureStatusBar(statusItem: statusItem, accessibilityEnabled: accessibilityEnabled)
    }
        
    func configureStatusBar(statusItem: NSStatusItem, accessibilityEnabled: Bool) {
        let button = statusItem.button!
        button.image = NSImage(systemSymbolName: "star", accessibilityDescription: nil)
                
        let menu = NSMenu()
        
        if !accessibilityEnabled {
            let enableItem = NSMenuItem(title: "グローバルショートカットを有効にする", action: #selector(enableQmd), keyEquivalent: "")
            enableItem.target = self
            menu.addItem(enableItem)
        }
        
        let openQmdItem = NSMenuItem(title: "qmdを開く", action: #selector(openQmd), keyEquivalent: "")
        openQmdItem.target = self
        menu.addItem(openQmdItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let settingsItem = NSMenuItem(title: "設定", action: #selector(showSettings), keyEquivalent: "")
        settingsItem.target = self
        menu.addItem(settingsItem)
        
        let quitItem = NSMenuItem(title: "終了", action: #selector(quitApp), keyEquivalent: "")
        quitItem.target = self
        menu.addItem(quitItem)
        
        statusItem.menu = menu
        
        registerShortcuts()
    }
    
    // "グローバルショートカットを有効にする" メニューアイテムの処理
    @objc func enableQmd() {
        // ユーザーにアクセシビリティアクセスを手動で許可するよう促す
        let alert = NSAlert()
        alert.messageText = "アクセシビリティアクセスが必要です"
        alert.informativeText = "このアプリケーションは正常に動作するためにアクセシビリティアクセスが必要です。「セキュリティとプライバシー」設定からアクセスを許可してください。"
        alert.runModal()
        
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        AXIsProcessTrustedWithOptions(options)
    }
    
    // "qmdを開く" メニューアイテムの処理
    @objc func openQmd() {
        openQmdAction()
    }
    
    // "設定" メニューアイテムの処理
    @objc func showSettings() {
        
    }
    
    // "終了" メニューアイテムの処理
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    func registerShortcuts() {
        // EventMonitorの多重登録を防ぐ
        if eventMonitor != nil {
            return
        }
        
        // グローバルショートカットの登録
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { event in
            if event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "q" {
                print("Cmd+Q")
            } else if event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "," {
                print("Cmd+,")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeEventMonitor), name: NSApplication.willTerminateNotification, object: nil)

    }
    
    @objc func removeEventMonitor() {
        if let em = eventMonitor {
            NSEvent.removeMonitor(em)
        }
    }
}
