//
//  utility.swift
//  SOFetch
//
//  Created by Yura on 11/27/20.
//

import UIKit

final class Utility {
    /// Construct URL based on specific parameters to be used to send a request for data.
    static var stackURL: URL? {
        let params = "?order=desc&sort=activity&accepted=True&site=stackoverflow"
        
        return URL(string: "https://api.stackexchange.com//2.2/search/advanced\(params)")
    }
    
    /// Send a request to Stack Overflow server to respond with a list of questions that have an accepted answer.
    static func fetchData() {
        if let stackURL = Utility.stackURL {
            URLSession.shared.dataTask(with: stackURL) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let serverData = data {
                        if let json = try? JSONSerialization.jsonObject(with: serverData, options: []) {
                            if let dictionary = json as? [String: Any] {
                                Utility.parse(serverResponse: dictionary)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    /// Parse the dictionary object of the JSON from the server and populate the fetchedQuestions array with questions that match the criteria. Criteria - The question with an accepted answer must contain more than 1 answer. Each object is being populated with 1: Title, 2: Tags, 3: Avatar of the person asking the question
    /// - Parameter json: JSON to parse.
    static func parse(serverResponse response: [String: Any]) {
        if let items = response["items"] as? [Any] {
            for item in items {
                if let itemDictionary = item as? [String: Any] {
                    if let answers = itemDictionary["answer_count"] as? Int {
                        if answers > 1 {
                            guard let questionTitle = itemDictionary["title"] as? String else { return }
                            //1
                            var question = Question(title: String(htmlEncodedString: questionTitle)) // might need to do this on main thread
                                                
                            if let tags = itemDictionary["tags"] as? [String] {
                                for tag in tags {
                                    question.tags.append(tag)
                                }
                            }
                            //2
                            question.link = itemDictionary["link"] as? String
                            //3
                            if let owner = itemDictionary["owner"] as? [String: Any] {
                                if let photoLink = owner["profile_image"] as? String {
                                    question.ownerPhotoURL = NSURL(string: photoLink) as URL?
                                }
                            }
                            
                            Utility.fetchedQuestions.append(question)
                        } else {
                            print("Only 1 answer.")
                        }
                    }
                }
            }
        }
        
        NotificationCenter.default.post(name: .UpdateUI, object: nil)
    }
    
    /// Datasource for the tableview - an array that contains all the questions retrieved from the server.
    static var fetchedQuestions = [Question]()
}

