//
//  EditorView.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/03/12.
//

import SwiftUI

struct EditorView: View {
    @State var text: String = ""
    
    private let pasteboard = NSPasteboard.general
    
    var body: some View {
        HostingWindowFinder { window in
            guard let w = window else { return }
            w.standardWindowButton(.miniaturizeButton)?.isEnabled = false
            w.standardWindowButton(.zoomButton)?.isEnabled = false
        }.frame(width:0,height:0) // disable frame
        
        
        TextEditor(text: $text)
            .padding(10)
            .background(.white)
            .onKeyPress { keyPress in
                if (keyPress.key == .return && keyPress.modifiers == .command) {
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString(text, forType: .string)
                    return .handled
                }
                return .ignored
            }
    }
}

struct HostingWindowFinder: NSViewRepresentable {
    var callback: (NSWindow?) -> ()
    
    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

#Preview {
    EditorView()
}
