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
