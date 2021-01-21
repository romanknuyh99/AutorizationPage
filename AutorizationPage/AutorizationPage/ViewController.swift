//
//  ViewController.swift
//  AutorizationPage
//
//  Created by Roman Kniukh on 3.01.21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            self.mainView.layer.cornerRadius = 75
            self.mainView.layer.shadowRadius = 75
            self.mainView.layer.shadowOpacity = 1
            self.mainView.layer.shadowColor = UIColor.white.cgColor
            self.mainView.layer.shadowOffset = CGSize(width: 10, height: 10)
        }
        
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.backgroundColor = .red
            self.imageView.image = UIImage(named: "loginImage")
            self.imageView.contentMode = .scaleAspectFill

            self.imageView.layer.cornerRadius = 75
            self.imageView.layer.shadowRadius = 75
            self.imageView.layer.shadowOpacity = 1
            self.imageView.layer.shadowColor = UIColor.red.cgColor
            self.imageView.layer.shadowOffset = CGSize(width: 20, height: 20)
            self.imageView.layer.borderWidth = 4
            self.imageView.layer.borderColor = UIColor.white.cgColor
            self.imageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.placeholder = "Enter your e-mail"
//            self.emailTextField.textColor = .lightGray
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.placeholder = "Enter your password"
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            self.errorLabel.isHidden = true
            self.errorLabel.textColor = .red
            self.errorLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.backgroundColor = .white
            self.loginButton.setTitle("LOGIN", for: .normal)
//            self.loginButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
            self.loginButton.layer.cornerRadius = 16
            self.loginButton.layer.borderColor = UIColor.white.cgColor
            self.loginButton.layer.borderWidth = 4

        }
    }
    // MARK: - Propertis
    var generationPassword = ""
    var buttonTouch = false
    
    // MARK: - Initializators
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generationPassword = PasswordGeneration.getPassword()
        self.view.backgroundColor = .blue
        
        print(generationPassword)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.layer.cornerRadius = mainView.bounds.width / 2
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    // MARK: - Action
        
    @IBAction func touchButton(_ sender: UITextField) {
        
//        if self.buttonTouch {
//            self.loginButton.backgroundColor = .orange
//            self.buttonTouch = false
//        } else {
//            self.loginButton.backgroundColor = .blue
//            self.buttonTouch = true
//        }
//
//        if self.errorLabel.isHidden == false {
//            self.errorLabel.isHidden = true
//            self.imageView.layer.borderColor = UIColor.white.cgColor
//        }
    
        loginButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside);
        loginButton.addTarget(self, action: #selector(heldDown), for: .touchDown)
        loginButton.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
        
        inputVerification()
    
        let newVC = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    // MARK: - Methods
    
    private func inputVerification() {
        guard let email = self.emailTextField.text else {
//            self.errorLabel.isHidden = false
//            self.errorLabel.text = "Please, enter your e-mail"
//            self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
//            self.emailTextField.layer.borderWidth = 4
            
            let alert = UIAlertController(title: "Error", message: "Please, enter your e-mail", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
            self.imageView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
//            self.errorLabel.isHidden = false
//            self.errorLabel.text = "Incorrect e-mail"
//            self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
//            self.emailTextField.layer.borderWidth = 4
            let alert = UIAlertController(title: "Error", message: "Incorrect e-mail", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
            self.imageView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        guard let password = self.passwordTextField.text else {
//            self.errorLabel.isHidden = false
//            self.errorLabel.text = "Please, enter your password"
//            self.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
//            self.passwordTextField.layer.borderWidth = 4
            
            let alert = UIAlertController(title: "Error", message: "Please, enter your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
            self.imageView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        guard password == self.generationPassword else {
//            self.errorLabel.isHidden = false
//            self.errorLabel.text = "Not correct password"
//            self.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
//            self.passwordTextField.layer.borderWidth = 4
            
            let alert = UIAlertController(title: "Error", message: "Incorrect password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
            self.imageView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        self.errorLabel.isHidden = true
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.image = UIImage(named: "photo1")
    }
    
    
    @objc func heldDown() {
        loginButton.backgroundColor = .blue
    }

    @objc func holdRelease() {
        loginButton.backgroundColor = .white
    }

    @objc func buttonHeldAndReleased() {
        loginButton.backgroundColor = .blue
    }
    
    
    
}

