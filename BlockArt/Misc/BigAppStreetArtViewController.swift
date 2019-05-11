//
//  BigAppStreetArtViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/11/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit
import WebKit

class BigAppStreetArtViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    override func viewDidLoad() {
      super.viewDidLoad()
      
      initView()
    }
    
    
    
    func initView() {
      webView = WKWebView()
      webView.navigationDelegate = self
      view = webView
      let url = URL(string: "http://blockart.be/game.html" )!  //EndPoint.streetART
      // http://blockart.be/game.html
      webView.load(URLRequest(url: url))
      webView.allowsBackForwardNavigationGestures = true
    }
}
