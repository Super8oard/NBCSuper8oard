//
//  SignInUpView.swift
//  NBCSuper8oard
//
//  Created by 洪立妍 on 1/16/24.
//



import UIKit

class AuthenticationViewController: UIViewController {

    var usersDictionary: [String: User] = [:]
    
    let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Kickboard")
        imageView.contentMode = .scaleAspectFit // 根据需要调整内容模式
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        view.addSubview(appLogoImageView)
        
        view.backgroundColor = .white

        // Add UI elements to the view
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)

        // Set up the button actions
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        // Layout UI elements
        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            appLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 180), // 根据需要调整宽度
            appLogoImageView.heightAnchor.constraint(equalToConstant: 180), // 根据需要调整高度
            
            idTextField.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 100),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        idTextField.delegate = self
        passwordTextField.delegate = self
    }

    @objc func loginButtonTapped() {
        guard let idToLogin = idTextField.text, !idToLogin.isEmpty,
                      let passwordToLogin = passwordTextField.text, !passwordToLogin.isEmpty else {
                    // Prompt the user to enter ID and password
                    showAlert(message: "아이디와 비밀번호를 입력해주세요")
                    return
                }
        
            //UserDefaults
//        if let user = usersDictionary[idToLogin], user.password == passwordToLogin {
//                    showAlert(message: "로그인 성공했습니다!")
//                } else {
//                    showAlert(message: "로그인 실패했습니다. 아이디 또는 비밀번호를 확인하세요.")
        
//        // 使用 UserDefaults 检索用户信息
        if let user = retrieveUserFromUserDefaults(forKey: idToLogin), user.password == passwordToLogin {
            UserDefaults.standard.set(idToLogin, forKey: "isLogin")
            showAlert(message: "로그인 성공했습니다!")
        } else {
            showAlert(message: "로그인 실패했습니다. 아이디 또는 비밀번호를 확인하세요.")
        }
    }
    
    
    
    
    func showAlert(message: String) {
         let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    

    @objc func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
           present(signUpViewController, animated: true, completion: nil)
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
}
