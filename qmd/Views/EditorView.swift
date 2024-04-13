//
//  EditorView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI

struct EditorView: View {
    @State var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
    }
}

#Preview {
    EditorView()
}
