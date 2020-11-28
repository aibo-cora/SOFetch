//
//  Question.swift
//  SOFetch
//
//  Created by Yura on 11/27/20.
//

import Foundation

struct Question: Hashable {
    let id = UUID()
    let title: String
    
    var viewCount: Int?
    var link: String?
    var acceptedAnswerID: String?
    var questionID: String?
    var creationData: Date?
    
    init(title: String) {
        self.title = title
    }
}
