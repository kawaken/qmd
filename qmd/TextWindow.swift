//
//  TextWindow.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/29.
//

import Cocoa
import SwiftUI

class TextWindow: NSWindow {
    
    init() {
        // ウィンドウのサイズ
        let windowWidth: CGFloat = 400
        let windowHeight: CGFloat = 300
        
        // ウィンドウのcontentRectを設定
        let contentRect = NSRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        let styleMask: NSWindow.StyleMask = [
            .titled,
            .closable,
            .resizable,
            .fullSizeContentView
        ]
        
        super.init(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)
        
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        
        self.level = .floating
        self.isReleasedWhenClosed = false
        self.hidesOnDeactivate = true
    }
    
    override var canBecomeMain: Bool {
        true
    }
    
    override var canBecomeKey: Bool {
        true
    }
}

// TODO: RoundedRectangleのドラッグでWindowを移動できるようにする
struct TextEditorView: View {
    @State private var text = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray.opacity(0.2))
            TextEditor(text: $text)
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// TODO: 別ファイルに整理する
class NSHostingViewSuppressingSafeArea<T : View>: NSHostingView<T> {
    required init(rootView: T) {
        super.init(rootView: rootView)

        addLayoutGuide(layoutGuide)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }

    private lazy var layoutGuide = NSLayoutGuide()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var safeAreaRect: NSRect {
        return frame
    }

    override var safeAreaInsets: NSEdgeInsets {
        return NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override var safeAreaLayoutGuide: NSLayoutGuide {
        return layoutGuide
    }

    override var additionalSafeAreaInsets: NSEdgeInsets {
        get {
            return NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        set {}
    }
}
