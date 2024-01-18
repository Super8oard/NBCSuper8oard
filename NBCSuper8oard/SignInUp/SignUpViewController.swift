//
//  SignUpViewController.swift
//  NBCSuper8oard
//
//  Created by 洪立妍 on 1/16/24.
//

import UIKit

class SignUpViewController: UIViewController {
    //  let usernameTextField: UITextField = {
    //    let textField = UITextField()
    //    textField.placeholder = "ID"
    //    textField.borderStyle = .roundedRect
    //    textField.translatesAutoresizingMaskIntoConstraints = false
    //    return textField
    //  }()
    //  let passwordTextField: UITextField = {
    //    let textField = UITextField()
    //    textField.placeholder = "비밀번호"
    //    textField.isSecureTextEntry = true
    //    textField.borderStyle = .roundedRect
    //    textField.translatesAutoresizingMaskIntoConstraints = false
    //    return textField
    //  }()
    //  let emailTextField: UITextField = {
    //    let textField = UITextField()
    //    textField.placeholder = "이메일"
    //    textField.keyboardType = .emailAddress
    //    textField.borderStyle = .roundedRect
    //    textField.translatesAutoresizingMaskIntoConstraints = false
    //    return textField
    //  }()
    //  let signUpButton: UIButton = {
    //    let button = UIButton(type: .system)
    //    button.setTitle("회원가입", for: .normal)
    //    button.translatesAutoresizingMaskIntoConstraints = false
    //    return button
    //  }()
    //  override func viewDidLoad() {
    //    super.viewDidLoad()
    //    view.backgroundColor = .white
    //    // Add UI elements to the view
    //    view.addSubview(usernameTextField)
    //    view.addSubview(passwordTextField)
    //    view.addSubview(emailTextField)
    //    view.addSubview(signUpButton)
    //    // Set up the button action
    //    signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    //    // Layout UI elements
    //    NSLayoutConstraint.activate([
    //      usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
    //      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    //      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    //      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
    //      passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    //      passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    //      emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
    //      emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    //      emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    //      signUpButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
    //      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    //    ])
    //  }
    //  @objc func signUpButtonTapped() {
    //    // Execute user sign-up logic here
    //    guard let username = usernameTextField.text, !username.isEmpty,
    //          let password = passwordTextField.text, !password.isEmpty,
    //          let email = emailTextField.text, !email.isEmpty else {
    //      // Prompt the user to enter complete information
    //      showAlert(message: "모든 필수 정보를 입력해주세요")
    //      return
    //    }
    //    // Execute user sign-up logic, such as calling an API or saving to a local database
    //    // After successful registration, you can navigate to another page or display a success message
    //    showAlert(message: "회원가입 성공합니다！")
    //  }
    //  func showAlert(message: String) {
    //    let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
    //    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    //    alert.addAction(okAction)
    //    present(alert, animated: true, completion: nil)
    //  }
    //}
    
       var usersDictionary: [String: User] = [:]
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "비밀번호 확인"
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "생년월일"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemYellow
        
        // Add UI elements to the view
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(birthDateTextField)
        view.addSubview(signUpButton)
      
        
        // Set up the button actions
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        
        // Layout UI elements
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            birthDateTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            birthDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            birthDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func signUpButtonTapped() {
        // Execute user sign-up logic here
        guard let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let birthDate = birthDateTextField.text, !birthDate.isEmpty else {
            // Prompt the user to enter complete information
            showAlert(message: "모든 필수 정보를 입력해주세요")
            return
            
        }
        
        // Check if the ID is already taken
        if usersDictionary[id] != nil {
            showAlert(message: "이미 사용 중인 아이디입니다.")
            return
        }
        
        // Check if passwords match
               if password == confirmPassword {
                   // Passwords match, you can proceed with registration logic
                   showAlert(message: "회원가입 성공합니다！")
               } else {
                   // Passwords don't match, show an alert
                   showAlert(message: "비밀번호가 일치하지 않습니다")
               }
        
        let newUser = User(id: id, password: password, name: name, phoneNumber: phoneNumber, email: email, birthDate: birthDate)
        usersDictionary[id] = newUser

        // Save user to UserDefaults using encoding
        saveUserToUserDefaults(newUser, forKey: id)

        // After successful registration, you can navigate to another page or display a success message
        showAlert(message: "회원가입 성공했습니다!")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
