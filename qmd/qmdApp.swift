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
        WindowGroup {
            EditorView()
        }
        
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
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .showMainWindow) {
            print("show")
        }
    }
}

