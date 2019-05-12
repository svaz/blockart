//
//  LoginViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/10/19.
//  Copyright © 2019 savio vaz. All rights reserved.

import UIKit
import RMessage

class LoginViewController: BaseViewController {

  @IBOutlet weak var loginEmail: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BlockArt"
    }
  
  override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
    
    if let ident = identifier {
      if ident == "tabVCSegue" {
        if loginSuccess() != true {
          return false
        }
      }
    }
    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier  == "tabVCSegue" {
//      let destVC : ScannerViewController = segue.destination as! ScannerViewController
//      destVC.transactionType = "SELL"
    }
  }
  
  @IBAction func loginAction(_ sender: Any) {
    self.performSegue(withIdentifier: "tabVCSegue", sender: nil)
  }
  
  
  func loginSuccess() -> Bool {
    
    let login = loginEmail.text
    var ethAddress: String?
    
      if login == Accounts.EmailAccounts.thomas {
        ethAddress = Accounts.EmailEth.thomas
      }
      
    if login == Accounts.EmailAccounts.mike {
      ethAddress = Accounts.EmailEth.mike
    }
    
    if login == Accounts.EmailAccounts.remco {
      ethAddress = Accounts.EmailEth.remco
    }
    if login == Accounts.EmailAccounts.jean {
      ethAddress = Accounts.EmailEth.jean
    }
    if login == Accounts.EmailAccounts.savio {
      ethAddress = Accounts.EmailEth.savio
    }
    return false
  }
  
}
