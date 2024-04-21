//
//  qmdApp.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let showMainWindow = Self("showMainWindow", default: Shortcut(.a, modifiers: [.command, .shift]))
}

@main
struct qmdApp: App {

    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup(id: "main-window") {
            EditorView()
        }.windowStyle(HiddenTitleBarWindowStyle())
        
        // システム常駐のメニューバー
        MenuBarExtra("qmd", systemImage: "star",
                     isInserted: $showMenuBarExtra)
        {
            SettingsLink(label: {
                Text("設定")
            })
            .keyboardShortcut(",")
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }

        // 設定
        Settings {
            SettingsView()
        }

    }
}

@MainActor
final class AppState: ObservableObject {
    
    @Environment(\.openWindow) private var openWindow
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .showMainWindow) { [self] in
            self.openWindow(id: "main-window")
        }
    }
}
