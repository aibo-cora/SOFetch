//
//  PreviewQuestion.swift
//  SOFetch
//
//  Created by Yura on 11/29/20.
//

import UIKit
import WebKit

class PreviewQuestion: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var questionURL: URL?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let questionURL = questionURL {
            let myRequest = URLRequest(url: questionURL)
            
            webView.load(myRequest)
        }
    }
}
