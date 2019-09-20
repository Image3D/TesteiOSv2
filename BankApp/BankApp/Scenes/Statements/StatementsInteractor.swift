//
//  StatementsInteractor.swift
//  BankApp
//
//  Created by Joni Campos on 19/09/19.
//  Copyright (c) 2019 Joni Campos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StatementsBusinessLogic
{
  func doSomething(request: Statements.Something.Request)
}

protocol StatementsDataStore
{
  //var name: String { get set }
}

class StatementsInteractor: StatementsBusinessLogic, StatementsDataStore
{
  var presenter: StatementsPresentationLogic?
  var worker: StatementsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Statements.Something.Request)
  {
    worker = StatementsWorker()
    worker?.doSomeWork()
    
    let response = Statements.Something.Response()
    presenter?.presentSomething(response: response)
  }
}