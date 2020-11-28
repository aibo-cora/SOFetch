//
//  ViewController.swift
//  SOFetch
//
//  Created by Yura on 11/27/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    enum Section: String, CaseIterable, Hashable {
        case main
    }
    typealias DataSource = UITableViewDiffableDataSource<Section, Question>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Question>
    
    var dataSource: DataSource! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = configureDataSource()
        
        tableView.register(QuestionViewCell.self, forCellReuseIdentifier: QuestionViewCell.reuseIdentifer)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        queryServer()
    }

    fileprivate func queryServer() {
//        Utility.fetchData()
        
        Utility.fetchedQuestions.append(Question(title: "Testing tableView."))
        updateTableView()
    }
    
    fileprivate func configureDataSource() ->
        UITableViewDiffableDataSource<Section, Question> {
        
        return UITableViewDiffableDataSource(tableView: tableView) {
            (tableView, indexPath, question) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuestionViewCell.reuseIdentifer, for: indexPath)
            
            
            return cell
        }
    }
    
    fileprivate func updateTableView() {
        var snapshot = Snapshot()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(Utility.fetchedQuestions, toSection: .main)
        
        DispatchQueue.main.async { [unowned self] in
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

