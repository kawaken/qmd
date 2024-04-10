//
//  qmdApp.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI

@main
struct qmdApp: App {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    
    var body: some Scene {
        WindowGroup {
            EditorView()
        }
        
        // システム常駐のメニューバー
        MenuBarExtra("qmd", systemImage: "star",
                     isInserted: $showMenuBarExtra)
        {
            Button("エディター") {
                
            }
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
