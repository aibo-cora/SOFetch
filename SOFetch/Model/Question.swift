//
//  Question.swift
//  SOFetch
//
//  Created by Yura on 11/27/20.
//

import UIKit

struct Question: Hashable {
    let id = UUID()
    let title: String?
    
    var tags = [String]()
    var viewCount: Int?
    var link: String?
    var acceptedAnswerID: String?
    var questionID: String?
    var creationData: Date?
    var ownerPhotoURL: URL?
    var ownerPhoto: UIImage?
    
    init(title: String?) {
        self.title = title
    }
}
