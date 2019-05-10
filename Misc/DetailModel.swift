//  Created by savio vaz on 5/7/19.
//  Copyright © 2019 savio vaz. All rights reserved.

import Foundation
import UIKit

protocol APIService {
  func fetchData(from endpoint: String, successHandler: @escaping (_ response: BTCXplorer) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

struct BTCXplorer: Codable {
  let addresses: [Address]
  let wallet: Wallet
  let txs: [Tx]
  let info: Info
  let recommendIncludeFee: Bool

  enum CodingKeys: String, CodingKey {
    case addresses, wallet, txs, info
    case recommendIncludeFee = "recommend_include_fee"
  }
}

struct Address: Codable {
  let address: String
  let nTx, totalReceived, totalSent, finalBalance: Int
  let changeIndex, accountIndex: Int

  enum CodingKeys: String, CodingKey {
    case address
    case nTx = "n_tx"
    case totalReceived = "total_received"
    case totalSent = "total_sent"
    case finalBalance = "final_balance"
    case changeIndex = "change_index"
    case accountIndex = "account_index"
  }
}

struct Info: Codable {
  let nconnected, conversion: Int
  let symbolLocal, symbolBtc: Symbol
  let latestBlock: LatestBlock

  enum CodingKeys: String, CodingKey {
    case nconnected, conversion
    case symbolLocal = "symbol_local"
    case symbolBtc = "symbol_btc"
    case latestBlock = "latest_block"
  }
}

struct LatestBlock: Codable {
  let blockIndex: Int
  let hash: String
  let height, time: Int

  enum CodingKeys: String, CodingKey {
    case blockIndex = "block_index"
    case hash, height, time
  }
}

struct Symbol: Codable {
  let code, symbol, name: String
  let conversion: Double
  let symbolAppearsAfter, local: Bool
}

struct Tx: Codable {
  let hash: String
  let time: Int
  let result: Int

  init(tx: Tx) {
    self.hash = tx.hash
    self.time = tx.time
    self.result = tx.result
  }
}

struct Input: Codable {
  let sequence: Int
  let witness: String
  let prevOut: Out
  let script: String

  enum CodingKeys: String, CodingKey {
    case sequence, witness
    case prevOut = "prev_out"
    case script
  }
}

struct Out: Codable {
  let type: Int
  let spent: Bool
  let xpub: Xpub?
  let value: Int
  let spendingOutpoints: [SpendingOutpoint]?
  let script: String
  let txIndex, n: Int
  let addr: String

  enum CodingKeys: String, CodingKey {
    case type, spent, xpub, value
    case spendingOutpoints = "spending_outpoints"
    case script
    case txIndex = "tx_index"
    case n, addr
  }
}

struct SpendingOutpoint: Codable {
  let txIndex, n: Int

  enum CodingKeys: String, CodingKey {
    case txIndex = "tx_index"
    case n
  }
}

struct Xpub: Codable {
  let m, path: String
}

struct Wallet: Codable {
  let nTx, nTxFiltered, totalReceived, totalSent: Int
  let finalBalance: Int

  enum CodingKeys: String, CodingKey {
    case nTx = "n_tx"
    case nTxFiltered = "n_tx_filtered"
    case totalReceived = "total_received"
    case totalSent = "total_sent"
    case finalBalance = "final_balance"
  }
}

public enum ServiceError: Error {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError
}
