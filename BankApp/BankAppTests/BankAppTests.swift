//
//  BankAppTests.swift
//  BankAppTests
//
//  Created by Joni Campos on 19/09/19.
//  Copyright © 2019 Joni Campos. All rights reserved.
//

import XCTest
@testable import BankApp

class BankAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // valida com senha correta
    func testValidaSenhaCorreta(){
        let senha = "Ta@3245235" // senha correta
        XCTAssertEqual(senha.validaSenha(),true)
    }
    
    func testValidaSenhaNoMaiuscula(){
        let senha = "ta@3245235" // senha sem maiscula
        XCTAssertEqual(senha.validaSenha(),false)
    }
    
    func testisNumber(){
        let numero = "2134986" // senha sem maiscula
        XCTAssertEqual(numero.isNumber(),true)
    }
    
    
    func testisNotNumber(){
        let numero = "A2347678" // senha sem maiscula
        XCTAssertEqual(numero.isNumber(),false)
    }
    
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
