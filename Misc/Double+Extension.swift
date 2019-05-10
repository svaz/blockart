//
//  Double+Extension.swift
//  BTCXPlorer
//
//  Created by savio vaz on 5/10/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import Foundation

extension Double {
  var stringValue: String {
    return "\(self)"
  }
  
  func avoidNotation() -> String {
    let number = NSNumber(value: self)
    return "\(number.decimalValue) BTC"
  }
}
