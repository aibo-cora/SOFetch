//
//  QuestionViewCell.swift
//  SOFetch
//
//  Created by Yura on 11/28/20.
//

import UIKit

class QuestionViewCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static let reuseIdentifer = "QuestionViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure() {
        accessoryType = .detailDisclosureButton
    }
}
