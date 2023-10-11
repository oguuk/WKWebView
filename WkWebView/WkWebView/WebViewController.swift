//
//  WebViewController.swift
//  WkWebView
//
//  Created by oguuk on 2023/10/09.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let contentController = WKUserContentController()
        contentController.add(self, name: "loginSuccess")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        let view = WKWebView(frame: .zero, configuration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()

        loadHTMLFile("Login")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func configureWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|", options: [], metrics: nil, views: ["webView": webView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|", options: [], metrics: nil, views: ["webView": webView]))
    }
    
    private func loadHTMLFile(_ name: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let url = Bundle.main.url(forResource: name, withExtension: "html") {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    self?.webView.load(request)
                }
            } else {
                print("DEBUG : Failed to find the HTML file for resource:", name)
            }
        }
    }
