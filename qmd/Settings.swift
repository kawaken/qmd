////
////  Settings.swift
////  qmd
////
////  Created by 河野健太朗 on 2024/03/12.
////
//
//import SwiftUI
//
//class Settings {
//    static let shared = Settings()
//    
//    private init() {}
//    
//    struct Keys {
//        static let firstLaunch = "firstLaunch"
//        static let fontName = "fontName"
//        static let fontSize = "fontSize"
//        static let textColor = "textColor"
//        static let backgroundColor = "backgroundColor"
//    }
//    
//    var firstLaunch: Bool{
//        get {
//            if let _ = UserDefaults.standard.value(forKey: Keys.firstLaunch) {
//                return UserDefaults.standard.bool(forKey: Keys.firstLaunch)
//            } else {
//                return true
//            }
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.firstLaunch)
//        }
//    }
//    
//    var fontName: String {
//        get {
//            UserDefaults.standard.string(forKey: Keys.fontName) ?? Font.system(size: 24)
//        }
//    }
//}
