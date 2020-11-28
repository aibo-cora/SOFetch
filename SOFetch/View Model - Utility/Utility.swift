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
                            Utility.parse(serverResponseJSON: json)
                        }
                    }
                }
            }.resume()
        }
    }
    
    /// Parse the Any object containing a JSON from the server and populate the fetchedQuestions array with questions that match the criteria
    /// - Parameter json: JSON to parse.
    static func parse(serverResponseJSON json: Any) {
        
    }
    
    /// Datasource for the tableview - an array that contains all the questions retrieved from the server.
    static var fetchedQuestions = [Question]()
}

