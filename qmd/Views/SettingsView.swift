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
        Form {
            KeyboardShortcuts.Recorder("Toggle Main Window:", name: .toggleMainWindow)
        }
    }
}
