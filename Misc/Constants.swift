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
    static let openLaw = "https://openlaw.io"
    static let streetArt = "http://blockart.be/game.html"
  }
  private  struct Routes {
    static let api = "/multiaddr?active="
  }
  private  static let domain = Domains.prod
  private  static let route = Routes.api
  static let baseURL = domain + route
  static let openLawContract = Domains.openLaw
  static let streetART = Domains.streetArt
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

 
/*
 ba-node1:
 User Account 0x275521480151576995D81503d16D3f2Caae6F13e
 
 ba-node2:
 User account 0x33F1612BE2C7d69174CF3F8e51eCD367C3DC984A
 
 ba-node3:
 User account 0x7f320C8BfAc1c1Ec81D41c7d56E2b7887De8bB1e
 
 ba-node4:
 user account 0x9467012Dd403BAa5290C65B4012b412Aefd44135
 
 ba-node5:
 user-account 0x5Be009baD4f63E23571f362FcD408EcC46Baec2D
 */
struct Accounts {
  private struct EmailAccounts {
    static let thomas = "thomaskplunkett@gmail.com"
    static let mike = "mike@rkosecurity.com"
    static let remco = "info@remcomichgels.nl"
    static let jean = "nounahon.j@gmail.com"
    static let savio = "saviovaz@gmail.com"
  }

  private struct EmailEth {
    static let thomas = "0x275521480151576995D81503d16D3f2Caae6F13e"
    static let mike = "0x33F1612BE2C7d69174CF3F8e51eCD367C3DC984A"
    static let remco = "0x7f320C8BfAc1c1Ec81D41c7d56E2b7887De8bB1e"
    static let jean = "0x9467012Dd403BAa5290C65B4012b412Aefd44135"
    static let savio = "0x5Be009baD4f63E23571f362FcD408EcC46Baec2D"
  }

}
 


