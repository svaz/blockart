//
//  APIService.swift
//  BTCXPlorer
//
//  Created by savio vaz on 5/7/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import Foundation
import UIKit

public class APIServiceStore: APIService {
  var transactionCount: Int = 0
  var photosCount: Int = 0
  var photoSectionCount: Int = 1 {
    didSet {
      print("Set section")
    }
  }
  init() {
 
  }

  func fetchDataFromFile(  successHandler: @escaping (BTCXplorer) -> Void,
                           errorHandler: @escaping (Error) -> Void) {
    let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
    do {
      let jsonData = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let response = try decoder.decode(BTCXplorer.self, from: jsonData)
       self.transactionCount = response.txs.count
      print("self.transactionCount = \(self.transactionCount)")
      DispatchQueue.main.async {
        successHandler(response)
      }
    } catch {
      print("******** ERROR" )
      self.handleError(errorHandler: errorHandler, error: ServiceError.invalidResponse)
    }
  }

  func fetchData(from endpoint: String, successHandler: @escaping (BTCXplorer) -> Void,
                 errorHandler: @escaping (Error) -> Void) {
    guard let url = URL(string: endpoint) else {
      errorHandler(ServiceError.invalidEndpoint)
      return
    }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if error != nil {
        self.handleError(errorHandler: errorHandler, error: ServiceError.apiError)
      }

      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        self.handleError(errorHandler: errorHandler, error: ServiceError.invalidResponse)
        return
      }

      guard let data = data else {
        self.handleError(errorHandler: errorHandler, error: ServiceError.noData)
        return
      }

      do {
        let response = try JSONDecoder().decode(BTCXplorer.self, from: data)
        self.transactionCount = response.txs.count
        DispatchQueue.main.async {
          successHandler(response)
        }
      } catch {
        self.handleError(errorHandler: errorHandler, error: ServiceError.serializationError)
      }

      }.resume()
  }

  private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
    DispatchQueue.main.async {
      errorHandler(error)
    }
  }
  
  
  func fetchArtData(from endpoint: String, successHandler: @escaping ([SavioPhoto]) -> Void,
                 errorHandler: @escaping (Error) -> Void) {
    guard let url = URL(string: endpoint) else {
      errorHandler(ServiceError.invalidEndpoint)
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if error != nil {
        self.handleError(errorHandler: errorHandler, error: ServiceError.apiError)
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        self.handleError(errorHandler: errorHandler, error: ServiceError.invalidResponse)
        return
      }
      
      guard let data = data else {
        self.handleError(errorHandler: errorHandler, error: ServiceError.noData)
        return
      }
      
      do {
        let response = try JSONDecoder().decode([SavioPhoto].self, from: data)
        DispatchQueue.main.async {
          successHandler(response)
        }
      } catch {
        self.handleError(errorHandler: errorHandler, error: ServiceError.serializationError)
      }
      
      }.resume()
  }
  
  
  func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      let transform = CGAffineTransform(scaleX: 3, y: 3)
      
      if let output = filter.outputImage?.transformed(by: transform) {
        return UIImage(ciImage: output)
      }
    }
    
    return nil
  }
  
  
  
}
