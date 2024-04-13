//
//  QMDDocument.swift
//  qmd
//
//  Created by 河野健太朗 on 2024/04/13.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let qmdDocument = UTType.utf8PlainText
}

struct QMDText: Identifiable, Codable {
    var id = UUID()
    var text: String
}

extension QMDText {
    static let empty = QMDText(text: "")
}

final class QMDDocument: ReferenceFileDocument {
    typealias Snapshot = QMDText
    
    @Published var text: QMDText
    
    static var readableContentTypes: [UTType] { [.qmdDocument] }
    
    func snapshot(contentType: UTType) throws -> QMDText {
        text
    }
    
    init() {
        text = .empty
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.text = try JSONDecoder().decode(QMDText.self, from: data)
    }
    
    func fileWrapper(snapshot: QMDText, configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(snapshot)
        let fileWrapper = FileWrapper(regularFileWithContents: data)
        return fileWrapper
    }
}
