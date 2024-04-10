//
//  MenuView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/13.
//

import SwiftUI

struct MenuView: View {

    
    var body: some View {
        Button("エディター") {
            showMainWindow()
        }
        Button("設定...") {
            showSettingsWindow()
        }
        .keyboardShortcut(",")
        Divider()
        Button("Quit") {
            NSApplication.shared.terminate(nil)
        }.keyboardShortcut("q")
    }

}
