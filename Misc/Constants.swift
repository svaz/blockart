//
//  Constants.swift
//  BTCXPlorer
//
//  Created by savio vaz on 5/8/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import Foundation
import UIKit

//1 btc = 100, 000,000 Satoshi
let BTC100Million = 100000000

// api endPoint
struct EndPoint {
  private struct Domains {
    static let dev = "http://dev.blockchain.info"
    static let uat = "http://test.blockchain.info"
    static let local = "192.111.1.1"
    static let qav = "http://qa.blockchain.info"
    static let prod = "https://blockchain.info"
  }
  private  struct Routes {
    static let api = "/multiaddr?active="
  }
  private  static let domain = Domains.prod
  private  static let route = Routes.api
  static let baseURL = domain + route
  static let btcDefaultAddress = "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
  static var endPointURL: String {
    return baseURL  + btcDefaultAddress
  }
}

struct AppColor {
  private struct RowColor {
    static let redColor = UIColor.red
    static let greenColor = UIColor(red: 0.01, green: 0.79, blue: 0.79, alpha: 1.0)
    static let altRowColor = UIColor(red: 0.97, green: 0.98, blue: 0.90, alpha: 1.0)
    static let whiteRowColor = UIColor.white
  }
  static let redColor = RowColor.redColor
  static let  greenColor = RowColor.greenColor
  static let  altRowColor = RowColor.altRowColor
  static let  whiteRowColor = RowColor.whiteRowColor
}

 

 


