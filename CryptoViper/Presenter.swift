//
//  Presenter.swift
//  CryptoViper
//
//  Created by Ali on 9.04.2022.
//

import Foundation

enum NetworkError: Error {
  case NetworkFailed
  case ParsingFailed 
}

protocol AnyPresenter {
  var router: AnyRouter? { get set }
  var interactor: AnyInteractor? { get set }
  var view: AnyView? {get set}

  func interactorDidDowloandCrypto(result: Result<[Crypto], Error>)
}

class CryptoPresenter: AnyPresenter {
  var router: AnyRouter?
  var interactor: AnyInteractor? {
    didSet{
      interactor?.dowloandCryptos()
    }
  }
  var view: AnyView?

  func interactorDidDowloandCrypto(result: Result<[Crypto], Error>) {
    switch result {
    case.success(let cryptos):
      view?.update(with: cryptos)
    case.failure(_ ):
      view?.update(with: "Try again later..")
    }
  }
}
