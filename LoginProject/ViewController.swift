//
//  ViewController.swift
//  LoginProject
//
//  Created by HYUKMIN KWON on 10/10/25.
//

import UIKit


// class - Dynamic Dispatch(Table Dispatch) -> Struct보다 느리므로, final 키워드를 붙여 더 이상 상속을 못하게 하여 Direct Dispatch 가 일어나도록 함
final class ViewController: UIViewController{
  
  // MARK: - 이메일 입력 TextView
  private lazy var emailTextFieldView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    
    view.addSubview(emailInfoLabel)
    view.addSubview(emailTextField)
    
    // closure 실행 후, view return
    return view
  }()
  
  
  private var emailInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "이메일 주소 또는 전화번호"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.white

    return label
  }()
  

  private lazy var emailTextField: UITextField = {
    var textField = UITextField()
    
    textField.frame.size.height = 48
    textField.backgroundColor = .clear
    textField.textColor = .white
    textField.tintColor = .white
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    textField.keyboardType = .emailAddress
    
    textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    
    return textField
  }()
  
  
  // MARK: - 비밀번호 입력 TextView
  private lazy var passwordTextFieldView: UIView = {
    let view = UIView()
    
    view.frame.size.height = 48
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    
    view.addSubview(passwordInfoLabel)
    view.addSubview(passwordTextField)
    view.addSubview(passwordSecureButton)
    
    return view;
  }()
  
  private var passwordInfoLabel: UILabel = {
    let label = UILabel()
    
    label.text = "비밀번호"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.white
    
    return label
  }()
  
  private lazy var passwordTextField : UITextField = {
    var textField = UITextField()
    
    textField.frame.size.height = 48
    textField.backgroundColor = .clear
    textField.textColor = .white
    textField.tintColor = .white
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    textField.isSecureTextEntry = true // 비밀번호를 가리는 설정
    textField.clearsOnBeginEditing = false
    
    textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    
    return textField
  }()
  
  private let passwordSecureButton: UIButton = {
    let button = UIButton(type: .custom)
    
    button.setTitle("표시", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
    button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
    
    return button
  }()
  
  
  // MARK: - 로그인 버튼
  private let loginButton: UIButton = {
    let button = UIButton(type: .custom) // .custom or .system
    
    button.backgroundColor = .clear
    button.layer.cornerRadius = 5
    button.clipsToBounds = true // cornerRadius와 couple
    button.layer.borderWidth = 1
    button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    button.setTitle("로그인", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.isEnabled = false
    
    button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  
  lazy var stackView: UIStackView = {
    // UIStackView(frame: )
    // UIStackView(arrangedSubView: [UIView])
    let stackView = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
    
    // configureUI에서
    /**
     stackView.addSubview(emailTextFieldView)
     stackView.addSubview(passwordTextFieldView)
     stackView.addSubview(loginButton)
     
     이렇게 해도 됨
   */
    
    stackView.spacing = 18
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    
    return stackView
  }()
  
  private let passwordResetButton: UIButton = {
    let button = UIButton()
    
    button.backgroundColor = .clear
    button.setTitle("비밀번호 재설정", for : .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    
    return button
  }()

  private let textViewHeight: CGFloat = 48
  
  // AutoLayout 향후 변경을 위한 변수 (Animation)
  lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
  
  lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
  
    configureUI()
  }
  
  func configureUI() {
    view.backgroundColor = UIColor.black
    self.view.addSubview(stackView)
    self.view.addSubview(passwordResetButton)
    
    emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
      emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
//      emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor), // label을 동적으로 이동하게 만들어야 해서 고정값을 주면 안됌
      emailInfoLabelCenterYConstraint,
      
      emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
      emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
      emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
      emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
      
      passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
      passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
//      passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
      passwordInfoLabelCenterYConstraint,
      
      passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
      passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
      passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
      passwordTextField.trailingAnchor.constraint(equalTo:passwordTextFieldView.trailingAnchor, constant: 8),
      
      passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
      passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
      passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
      
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      stackView.heightAnchor.constraint(equalToConstant: textViewHeight * 3 + 36),
      
      passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
      passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30 ),
      passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
    ])
    // emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
    // emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8).isActive = true
    // emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor).isActive = true

    
    //    emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
    //    emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8).isActive = true
    //    emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15).isActive = true
    //    emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2).isActive = true
    
  }
  
  @objc func loginButtonTapped() {
    print("로그인 버튼이 눌렸습니다.")
  }
  
  // #selector(
  @objc func resetButtonTapped() {
    let alert = UIAlertController( title: "Reset Password", message: "Do you want to change password", preferredStyle: .alert) // .alert | .actionSheet
    
    
    
    let success = UIAlertAction(title: "Confirm", style: .default) { action in
      print("Confirm is tapped")
    }
    
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
      print("Cancel is tapped")
    }
    
    // view.addSubview와 같은 역할
    alert.addAction(success)
    alert.addAction(cancel)
    
    // 다음 화면으로 넘어가는 메서드
    present(alert, animated: true) {
      print("Complete")
    }
    //    present(alert, animated: true, completion: nil)
   
  }
  
  @objc func passwordSecureModeSetting() {
    passwordTextField.isSecureTextEntry.toggle()
  }
  
  // 주변 영역을 터치하면 keyboard 내려감
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    
  }
}


// extension 확장
extension ViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == emailTextField {
      emailTextFieldView.backgroundColor = UIColor.gray
      emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
      
      // AutoLayout Update
      emailInfoLabelCenterYConstraint.constant = -13
    }
    
    if textField == passwordTextField {
      passwordTextFieldView.backgroundColor = UIColor.gray
      passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
      
      // AutoLayout Update
      passwordInfoLabelCenterYConstraint.constant = -13
    }
    
    UIView.animate(withDuration: 0.3) {
      self.stackView.layoutIfNeeded() // run loop (1s 60번 화면을 다시 그림) -> 애니메이션이 띄엄띄엄 그림을 그리는게 아니라, 자연스럽게 그리는 코드
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == emailTextField {
      emailTextFieldView.backgroundColor = UIColor.darkGray
      
      if emailTextField.text == "" {
        emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
        
        // AutoLayout Update
        emailInfoLabelCenterYConstraint.constant = 0
      }
    }
    
    if textField == passwordTextField {
      passwordTextFieldView.backgroundColor = UIColor.darkGray
      
      if passwordTextField.text == "" {
        passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
        
        // AutoLayout Update
        passwordInfoLabelCenterYConstraint.constant = 0
      }
    }
    
    UIView.animate(withDuration: 0.3) {
      self.stackView.layoutIfNeeded()
    }
  }
  
  
  @objc func textFieldEditingChanged(_ textField : UITextField) {
    if textField.text?.count == 1{
      if textField.text?.first == " "{
        textField.text = ""
        return
      }
    }
    
    guard
      let email = emailTextField.text, !email.isEmpty,
      let password = passwordTextField.text, !password.isEmpty else {
      loginButton.backgroundColor = .clear
      loginButton.isEnabled = false
      return
    }
    
    loginButton.backgroundColor = .red
    loginButton.isEnabled = true
  }
  }
  
 
  

}
