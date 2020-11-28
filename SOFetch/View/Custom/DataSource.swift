//
//  DataSource.swift
//  SOFetch
//
//  Created by Yura on 11/28/20.
//

import UIKit

final class CustomDataSource: UITableViewDiffableDataSource<Section, Question> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Stack Overflow questions with accepted answers."
    }
    
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<Section, Question>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
    }
}
