//
//  ContractWebViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/11/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit
import WebKit

class ContractWebViewController: UIViewController, WKNavigationDelegate {
var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
  
  func initView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
    let url = URL(string: "https://google.com")!  //EndPoint.openLawContract
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
  }
}
