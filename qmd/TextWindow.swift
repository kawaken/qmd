//
//  TextWindow.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/29.
//

import Cocoa

class TextWindow: NSWindow {
    init() {
        // ウィンドウのサイズ
        let windowWidth: CGFloat = 400
        let windowHeight: CGFloat = 300
        
        // ウィンドウのcontentRectを設定
        let contentRect = NSRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        
        super.init(contentRect: contentRect, styleMask: [.borderless], backing: .buffered, defer: false)
        
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
