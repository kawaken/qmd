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
        HostingWindowFinder { window in
            guard let w = window else { return }
            w.standardWindowButton(.closeButton)?.isEnabled = false
            w.standardWindowButton(.miniaturizeButton)?.isEnabled = false
            w.standardWindowButton(.zoomButton)?.isEnabled = false
        }.frame(width:0,height:0) // disable frame
        
        HStack {
            TextEditor(text: $text)
                .padding(10)
                .background(.white)
        }
            .background(KeyEventHandling(modifierFlags: .command, keyUpCharacter: "a") {
                print(text)
            })
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

struct KeyEventHandling: NSViewRepresentable {
    
    var handler:Handler
    
    init(modifierFlags: NSEvent.ModifierFlags, keyUpCharacter: String?, action: @escaping () -> ()) {
        self.handler = Handler(modifierFlags: modifierFlags, keyUpCharacter:keyUpCharacter, action:action)
    }

    class Handler {
        var modifierFlags: NSEvent.ModifierFlags = []
        var keyUpCharacter: String? = nil
        var action: () -> ()
        
        init(modifierFlags: NSEvent.ModifierFlags, keyUpCharacter: String?, action: @escaping () -> ()) {
            self.modifierFlags = modifierFlags
            self.keyUpCharacter = keyUpCharacter
            self.action = action
        }
        
        func handleEvent(_ event: NSEvent) {
            print("hello")
            if (event.modifierFlags.contains(modifierFlags) && event.characters == keyUpCharacter) {
                self.action()
            }
        }
    }
    
    class KeyView: NSView {
        var handler: Handler?
        
        override var acceptsFirstResponder: Bool {
            true
        }
                
        override func keyUp(with event: NSEvent) {
            super.keyUp(with: event)
            handler?.handleEvent(event)
        }
    }
    
    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        view.handler = handler
        
        DispatchQueue.main.async { // wait till next event cycle
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

#Preview {
    EditorView()
}
