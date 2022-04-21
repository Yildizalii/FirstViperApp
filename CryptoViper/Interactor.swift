//
//  Interactor.swift
//  CryptoViper
//
//  Created by Ali on 9.04.2022.
//

import Foundation

protocol AnyInteractor {
  var presenter: AnyPresenter? {get set}
  func dowloandCryptos()
}

class CryptoInteractor: AnyInteractor {
  var presenter: AnyPresenter?
  func dowloandCryptos() {
    guard let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
      return
    }
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data, error == nil else {
        self?.presenter?.interactorDidDowloandCrypto(result: .failure(NetworkError.NetworkFailed))
        return
      }
      do {
        let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
        self?.presenter?.interactorDidDowloandCrypto(result: .success(cryptos))
      }catch {
        self?.presenter?.interactorDidDowloandCrypto(result: .failure(NetworkError.ParsingFailed))
      }
    }
    task.resume()
  }
}
