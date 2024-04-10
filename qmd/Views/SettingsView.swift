//
//  SettingsView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/13.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Text("General")
                .tabItem { Label("General", systemImage: "gear") }
                .navigationTitle("ParentTitle")
                .navigationSubtitle("General")
            Text("Typography")
                .tabItem { Label("Typography", systemImage: "textformat") }
            
        }
    }
}
