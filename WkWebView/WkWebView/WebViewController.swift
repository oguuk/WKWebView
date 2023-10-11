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
