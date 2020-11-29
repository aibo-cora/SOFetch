//
//  String.swift
//  SOFetch
//
//  Created by Yura on 11/29/20.
//

import Foundation

extension String {
    
    /// Decode HTML entities from returned JSON strings
    /// - Parameter htmlEncodedString: String with HTML code
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }
}
