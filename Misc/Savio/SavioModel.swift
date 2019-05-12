//
//  SavioModel.swift
//  SavioVaz
//
//  Created by savio vaz on 4/23/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import Foundation


struct SavioList: Codable {
  let savioList: [SavioPhoto]?
}

struct SavioPhoto: Codable {
  let albumId, id: Int?
  let title: String?
  let imageFile: String?
  let url, thumbnailUrl: String?
  let creationDate, description, price, olContractUrl, artist: String?
  init(savioPhoto: SavioPhoto) {
    self.albumId = savioPhoto.albumId
    self.title = savioPhoto.title
    self.url = savioPhoto.url
    self.thumbnailUrl = savioPhoto.thumbnailUrl
    self.id = savioPhoto.id
    self.imageFile = savioPhoto.imageFile
    self.creationDate = savioPhoto.creationDate
    self.description = savioPhoto.description
    self.price = savioPhoto.price
    self.olContractUrl = savioPhoto.olContractUrl
    self.artist = savioPhoto.artist
    
  }
}

extension SavioPhoto: Hashable {
  var hashAlbumIdValue: Int {
    if let albumId = self.albumId {
      return albumId } else {
      return 0
    }
  }
}
//public enum ServiceError: Error {
//  case apiError
//  case invalidEndpoint
//  case invalidResponse
//  case noData
//  case serializationError
//}
