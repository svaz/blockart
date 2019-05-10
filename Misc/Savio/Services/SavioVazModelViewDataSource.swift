//
//   
//
//
//  Created by savio vaz on 4/23/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//
import Foundation
import UIKit

let endPointURL =  "https://jsonplaceholder.typicode.com/photos"

//public enum Result<Value> {
//  case success(Value)
//  case failure(Error)
//}

// Used in various calls
enum RetrievedType {
  case photos
  case people
  case things
}

//protocol APIService {
//  func fetchData(from endpoint: String, successHandler: @escaping (_ response: [SavioPhoto]) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
//}

protocol SavioModelDataSourceDelegate {
  func loadData()
  func postError(message: String)
}

open class SavioModelViewDataSource: NSObject {
  var delegate: SavioModelDataSourceDelegate?
  
  var allPhotos :[SavioPhoto]?{
    didSet {
      self.delegate?.loadData()
    }
  }

  var photosCount: Int = 0
  var photoSectionCount: Int = 1 {
    didSet {
      print("Set section")
    }
  }
  var updateLoadingStatusClosure: (()->())?
  var isLoading: Bool = false {
    didSet {
      self.updateLoadingStatusClosure?()
    }
  }
  var errorMessage: String? {
    didSet{
      self.delegate?.postError(message: errorMessage!)
    }
  }

  public override init() {
    super.init()
  }

  func getData(retrievedType: RetrievedType) {
    guard let url = URL(string: endPointURL) else {

      self.errorMessage = "Bad URL"
      return
    }

    self.allPhotos = nil
    self.isLoading = true
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      self.isLoading = false
      guard let data = data else {
        self.errorMessage = "Bad Data in API"
        return
      }
      
      
      self.handleReturnedData(retrievedType: retrievedType, data: data)
      if error != nil {
        print(error ?? "Error getting Data")
        self.errorMessage = "Error in gettin Data \(String(describing: error))"
      }
      }.resume()
  }

  func handleReturnedData(retrievedType: RetrievedType, data: Data) {
    do {
      switch retrievedType {
      case .photos:
        self.allPhotos = nil
        let json = try JSONDecoder().decode([SavioPhoto].self, from: data)
        self.allPhotos = json
        self.photosCount = json.count

      case .people:
        // for other type of returned data
         print("Waitin on other calls")
      default:
       print("Waitin on other calls")
      }

    } catch {
      print("Error in Retrieving Data   API = \(error)")
      self.errorMessage = "Error in Retrieving Data   API = \(error)"
    }
  }
}

//public class APIServiceStore: APIService{
//  
//  
//    init() {}
//
//
//  func fetchData(from endpoint: String, successHandler: @escaping ([SavioPhoto]) -> Void, errorHandler: @escaping (Error) -> Void) {
//    
//      guard let url = URL(string: endpoint) else{
//         errorHandler(ServiceError.invalidEndpoint)
//        return
//      }
//    
//      URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if error != nil {
//           self.handleError(errorHandler: errorHandler, error: ServiceError.apiError)
//        }
//        
//        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//          self.handleError(errorHandler: errorHandler, error: ServiceError.invalidResponse)
//          return
//        }
//        
//        guard let data = data else {
//          self.handleError(errorHandler: errorHandler, error: ServiceError.noData)
//          return
//        }
//        
//        do {
//          let response = try JSONDecoder().decode([SavioPhoto].self, from: data)
//          DispatchQueue.main.async {
//            successHandler(response)
//          }
//        } catch {
//          self.handleError(errorHandler: errorHandler, error: ServiceError.serializationError)
//        }
//       
//        }.resume()
//    }
//  
//  
//  private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
//    DispatchQueue.main.async {
//      errorHandler(error)
//    }
//  }
//  
//  
//}
//
//
//
