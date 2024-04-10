//
//  EditorView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI

struct EditorView: View {
    enum Mode: String, CaseIterable, Identifiable {
        case edit = "Edit"
        
        var id: String { rawValue}
    }
    
    @State private var content = ""
    @State private var mode = Mode.edit
        
    var body: some View {
        HStack(spacing: 0.0) {
            if mode == .edit {
                TextEditor(text: $content)
            }
        }
    }
}

#Preview {
    EditorView()
}
