//
//  qmdApp.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI

@main
struct qmdApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: { QMDDocument() }) { configuration in
            EditorView()
        }
    }
    
//    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
//    
//    @State private var editorViews: [EditorView] = [EditorView()]
//    
//    var body: some Scene {
//        WindowGroup {
//            editorViews.first
//        }
//        
//        // システム常駐のメニューバー
//        MenuBarExtra("qmd", systemImage: "star",
//                     isInserted: $showMenuBarExtra)
//        {
//            Button("エディター") {
//                let view = EditorView()
//                editorViews.append(view)
//            }
//            SettingsLink(label: {
//                Text("設定")
//            })
//            .keyboardShortcut(",")
//            Divider()
//            Button("Quit") {
//                NSApplication.shared.terminate(nil)
//            }.keyboardShortcut("q")
//        }
//        
//        // 設定
//        Settings {
//            SettingsView()
//        }
//    }
}
