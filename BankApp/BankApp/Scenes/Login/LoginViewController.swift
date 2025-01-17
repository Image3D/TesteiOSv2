//
//  LoginViewController.swift
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



// tester flag
var tester = false


protocol LoginDisplayLogic: class
{
  func showStatement()
    
 
}

class LoginViewController: UIViewController, LoginDisplayLogic{
    
    
    //call a tela Statement
    func showStatement() {
        performSegue(withIdentifier: "Statements", sender: nil)
    }
    
    
    //mark Campos input
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
  var interactor: LoginBusinessLogic?
  var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    //doSomething()
    
    
  
    
    //pega ultimo usuario logado
    getUsuario()
    
    
    
    
  }
    
    
   //keep me logged
    func getUsuario() {
        //Verifica se tem usuario e senha já no arquivo de keychain
        if let usuario = KeychainService.loadPassword(service: "MyUser" , account: "BankApp"), let senha = KeychainService.loadPassword(service: "MyPass", account: "BankApp"){
            
            //Atribui o usuario e senha salvos (do ultimo usuario logado) aos campos na tela
            self.userInput.text = usuario
            self.passwordInput.text = senha
        }
    }
    
    
    
    
    
    
  
  // MARK: Call interactor
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  //Clean-Swift template func doSomething()
    //call a função doSomething() do LoginInteractor.swift 
  func callInteractor()
        
  {
    
    //set parametros no stuct Request no LoginModels.swift
    var request2 = Login.Something.Request()
    request2.user = userInput.text
    request2.password = passwordInput.text
    
    //chama o interactor passando a estrutura do Request
    //let request = Login.Something.Request()
    interactor?.login(request: request2)
  }
  
    
    
    
  func displaySomething(viewModel: Login.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
    
    // Aqui você irá mostrar o que vem do LoginPresenter se for o caso.
    
    
  }
    
    
    //monte um Alert Controller
    func showAlert(message: String)
    {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        showDetailViewController(alert, sender: nil)
    }
    
    @IBAction func loginButton(_ sender: Any){
        //botao Login foi apertado
        // Chame a rotina de validação de login
        self.executeLogin()
    }
    
    
    // executa a vlidação dos camnpos
    func executeLogin()
    {
        let usuario = userInput.text!
        let senha = passwordInput.text!
        
        
        
        // valida campos
        //verifica se campos vazios
        
        //verifica se Campo User é vazio
        if usuario.isEmpty
        {
            showAlert(message: "O campo User não pode ser vazio")
            self.userInput.becomeFirstResponder()
            return
        }
        
        //verifica se campo Pasword é vazio
        if  senha.isEmpty
        {
            showAlert(message: "O campo Password não pode ser vazio")
            self.passwordInput.becomeFirstResponder()
            return
        }
        
        //valida campo User
        if !(usuario.contains("@") && usuario.contains("."))
        {
            //Não é e-mail, verifica se é CPF
            var cpf = usuario.replacingOccurrences(of: ".", with: "")
            cpf = cpf.replacingOccurrences(of: "-", with: "")
            
            if !(cpf.isNumber() && cpf.count == 11)
            {
                //Não é CPF também, exibe mensagem para usuário
                showAlert(message: "E-mail ou CPF inválido, favor tentar novamente.")
                return
            }
        }
        
        
        
        //Faz a validação da senha
        if !senha.validaSenha()
        {
            //A senha não está no padrão. Exibe mensagem para o usuário
            showAlert(message: "A senha deve conter pelo menos uma letra maiuscula, um caracter especial e um caracter alfanumérico.")
            return
        }
        
        //Campos foram Call Login API
        //chamae o Interactor passando a estrutura do request
        callInteractor()
        
    }
    
    
}


