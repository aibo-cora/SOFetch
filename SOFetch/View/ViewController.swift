//
//  ViewController.swift
//  SOFetch
//
//  Created by Yura on 11/27/20.
//

import UIKit

enum Section: String, CaseIterable, Hashable {
    case main
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    typealias DataSource = CustomDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Question>
    
    var dataSource: DataSource! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView(_:)), name: .UpdateUI, object: nil)
        
        dataSource = configureDataSource()
        
        tableView.register(QuestionViewCell.self, forCellReuseIdentifier: QuestionViewCell.reuseIdentifer)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        Utility.fetchData()
    }
    
    /// Populate the tableView with cells containing data from server. Cells display title of the question and tags.
    /// - Returns: Individual cell.
    fileprivate func configureDataSource() -> DataSource {
        return DataSource(tableView: tableView) {
            (tableView, indexPath, question) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuestionViewCell.reuseIdentifer, for: indexPath)
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.text = question.title
            
            var subtitle = ""
            for tag in question.tags {
                subtitle.append("#\(tag) ")
            }
            
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.text = subtitle
            cell.detailTextLabel?.textColor = UIColor(red: 128/255, green: 0, blue: 0,alpha: 1)
            
            if let avatarURL = question.ownerPhotoURL {
                URLSession.shared.dataTask(with: avatarURL) { (data, response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if let imageData = data {
                            DispatchQueue.main.async {
                                cell.imageView?.image = UIImage(data: imageData)
                            }
                        }
                    }
                }.resume()
            }
            
            return cell
        }
    }
    
    /// This method is called when a response, received from the SO server, is parsed. It tells the tableView data source which sections need to be updated.
    /// - Parameter notification: UpdateUI notification.
    @objc fileprivate func updateTableView(_ notification: NSNotification) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(Utility.fetchedQuestions, toSection: .main)
        
        DispatchQueue.main.async { [unowned self] in
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

//MARK: - UITableViewDelegate methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let menuConfiguration = UIContextMenuConfiguration(identifier: "Question Menu" as NSCopying, previewProvider: nil) { (menuElement) -> UIMenu? in
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) {
                (action) in
                
            }
            
            let menu = UIMenu(title: "", image: nil, identifier: .none, options: .displayInline, children: [delete])
            return menu
        }
        return menuConfiguration
    }
}
