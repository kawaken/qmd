//
//  SettingsView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/13.
//

import SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    var body: some View {
        TabView {
            KeyboardShortcuts.Recorder("Show Main Window:", name: .showMainWindow)
                .tabItem {
                    Label("Shortcut", systemImage: "keyboard")
                }
        }
        .frame(width: 400, height: 300)
    }
}
