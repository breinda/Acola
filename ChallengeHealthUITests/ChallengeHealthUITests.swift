//
//  ChallengeHealthUITests.swift
//  ChallengeHealthUITests
//
//  Created by Brenda Carrocino on 13/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import XCTest
import FirebaseAuth
import Firebase

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in "\u{8}" }.joined(separator: "")
        // let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
    }
}

class ChallengeHealthUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        //FirebaseApp.configure()
        
        var firAuth: Auth = {
            if FirebaseApp.app() == nil { FirebaseApp.configure() }
            return Auth.auth()
        }()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCadastro() {
        
        // given
        let nomeTextField = app.textFields["Qual é o seu nome?"]
        let olaButton = app.buttons["OLÁ!"]
        
        let emailTextField = app.textFields["e-mail"]
        let senhaTextField = app.secureTextFields["senha"]
        let confirmarSenhaTextField = app.secureTextFields["confirmar senha"]
        let tudoCertoButton = app.buttons["TUDO CERTO"]
        
        let boddiImage = app.images["boddiImage"]
        
        let alert1 = app.alerts["erro 1 - Problema no cadastro"]
        let alert2 = app.alerts["erro 2 - Problema no cadastro"]
        let alert3 = app.alerts["erro 3 - Problema no cadastro"]
        let alert4 = app.alerts["erro 4 - Problema no cadastro"]
        
        // then
        // tela de login
        
        XCTAssert(app.buttons["quero me cadastrar!"].exists)
        app.buttons["quero me cadastrar!"].tap()
        
        // tela de cadastro
        
        XCTAssert(boddiImage.exists)
        XCTAssert(nomeTextField.exists)
        XCTAssert(olaButton.exists)
        XCTAssert(!emailTextField.exists)
        XCTAssert(!senhaTextField.exists)
        XCTAssert(!confirmarSenhaTextField.exists)
        XCTAssert(!tudoCertoButton.exists)

        // nome não inserido
        olaButton.tap()
        
        XCTAssert(nomeTextField.exists)
        XCTAssert(olaButton.exists)
        XCTAssert(!emailTextField.exists)
        XCTAssert(!senhaTextField.exists)
        XCTAssert(!confirmarSenhaTextField.exists)
        XCTAssert(!tudoCertoButton.exists)
        
        // nome inserido
        nomeTextField.tap()
        nomeTextField.typeText("fulano")
        boddiImage.tap()
        olaButton.tap()
        
        XCTAssert(!nomeTextField.exists)
        XCTAssert(!olaButton.exists)
        XCTAssert(emailTextField.exists)
        XCTAssert(senhaTextField.exists)
        XCTAssert(confirmarSenhaTextField.exists)
        XCTAssert(tudoCertoButton.exists)
        
        // segunda parte da tela de cadastro
        
        // email não inserido
        senhaTextField.tap()
        senhaTextField.typeText("123456")
        boddiImage.tap()
        confirmarSenhaTextField.tap()
        confirmarSenhaTextField.typeText("123456")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // senha não inserida
        emailTextField.tap()
        emailTextField.typeText("y@y.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // confirmar senha não inserido
        //emailTextField.tap()
        emailTextField.clearAndEnterText("y@y.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // email + senha não inseridos
        //emailTextField.tap()
        emailTextField.clearAndEnterText("")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // email + confirmar senha não inseridos
        //emailTextField.tap()
        emailTextField.clearAndEnterText("")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // senha + confirmar senha não inseridos
        //emailTextField.tap()
        emailTextField.clearAndEnterText("y@y.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // nenhum dos campos inseridos
        //emailTextField.tap()
        emailTextField.clearAndEnterText("")
        boddiImage.tap()
       // senhaTextField.tap()
        senhaTextField.clearAndEnterText("")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert1.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        alert1.buttons["Tentar novamente"].tap()
        
        // email com formato desconhecido
        //emailTextField.tap()
        emailTextField.clearAndEnterText("yy.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert4.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert1.exists)
        alert4.buttons["Tentar novamente"].tap()
        
        // senha com menos de 6 caracteres
       // emailTextField.tap()
        emailTextField.clearAndEnterText("y@y.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("12345")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("12345")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert3.exists)
        XCTAssert(!alert2.exists)
        XCTAssert(!alert4.exists)
        XCTAssert(!alert1.exists)
        alert3.buttons["Tentar novamente"].tap()
        
        // senha e confirmar senha não coincidem
        //emailTextField.tap()
        emailTextField.clearAndEnterText("y@y.com")
        boddiImage.tap()
        //senhaTextField.tap()
        senhaTextField.clearAndEnterText("1234567")
        boddiImage.tap()
        //confirmarSenhaTextField.tap()
        confirmarSenhaTextField.clearAndEnterText("123456")
        boddiImage.tap()
        tudoCertoButton.tap()
        
        XCTAssert(alert2.exists)
        XCTAssert(!alert3.exists)
        XCTAssert(!alert4.exists)
        XCTAssert(!alert1.exists)
        alert2.buttons["Tentar novamente"].tap()
        
        // TO DO -- usuário já cadastrado
        
    }
    
    func testLogin() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // given
        XCTAssert(app.textFields["e-mail"].exists)
        XCTAssert(app.secureTextFields["senha"].exists)
        XCTAssert(app.buttons["ENTRAR"].exists)
        
        let emailTextField = app.textFields["e-mail"]
        let passwordTextField = app.secureTextFields["senha"]
        let loginButton = app.buttons["ENTRAR"]
        let acolaImage = app.images["acolaImage"]
        
        // then
        // nenhum campo preenchido
        loginButton.tap()
        
        XCTAssert(app.alerts["erro 1 - Problema no login"].exists)
        XCTAssert(!app.alerts["erro 0 - Problema no login"].exists)
        app.alerts["erro 1 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // apenas o campo de email preenchido
        emailTextField.tap()
        emailTextField.typeText("a@a.com")
        
        acolaImage.tap()
        
        loginButton.tap()
        
        XCTAssert(app.alerts["erro 1 - Problema no login"].exists)
        XCTAssert(!app.alerts["erro 0 - Problema no login"].exists)
        app.alerts["erro 1 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // apenas o campo de senha preenchido
        emailTextField.tap()
        emailTextField.clearAndEnterText("")
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        acolaImage.tap()
        loginButton.tap()
        
        XCTAssert(app.alerts["erro 1 - Problema no login"].exists)
        XCTAssert(!app.alerts["erro 0 - Problema no login"].exists)
        app.alerts["erro 1 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // tanto o campo de email quanto o de senha preenchidos com valores errados
        emailTextField.tap()
        emailTextField.clearAndEnterText("a@a.co")
        passwordTextField.tap()
        passwordTextField.clearAndEnterText("12345")
        
        acolaImage.tap()
        loginButton.tap()
        
        let alert0 = app.alerts["erro 0 - Problema no login"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: alert0, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(alert0.exists)
        XCTAssert(!app.alerts["erro 1 - Problema no login"].exists)
        app.alerts["erro 0 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // campo de senha preenchido com valor errado
        emailTextField.tap()
        emailTextField.clearAndEnterText("a@a.com")
        passwordTextField.tap()
        passwordTextField.clearAndEnterText("12345")
        
        acolaImage.tap()
        loginButton.tap()
        
        expectation(for: exists, evaluatedWith: alert0, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(alert0.exists)
        XCTAssert(!app.alerts["erro 1 - Problema no login"].exists)
        app.alerts["erro 0 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // campo de email preenchido com valor errado
        emailTextField.tap()
        emailTextField.clearAndEnterText("a@a.co")
        passwordTextField.tap()
        passwordTextField.clearAndEnterText("12346")
        
        acolaImage.tap()
        loginButton.tap()
        
        expectation(for: exists, evaluatedWith: alert0, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(alert0.exists)

        XCTAssert(!app.alerts["erro 1 - Problema no login"].exists)
        app.alerts["erro 0 - Problema no login"].buttons["Tentar novamente"].tap()
        
        // combinação email-senha correta
        emailTextField.tap()
        emailTextField.clearAndEnterText("a@a.com")
        passwordTextField.tap()
        passwordTextField.clearAndEnterText("123456")
        
        acolaImage.tap()
        loginButton.tap()
        
        XCTAssert(!app.alerts["erro 1 - Problema no login"].exists)
        XCTAssert(!app.alerts["erro 0 - Problema no login"].exists)
    }
    
}
