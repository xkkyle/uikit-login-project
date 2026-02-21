//
//  ViewController.swift
//  LoginProject
//
//  Created by HYUKMIN KWON on 10/10/25.
//

import UIKit

class ViewController: UIViewController {
  
  let emailTextFieldView = UIView()
  // view라고 이름을 지으면, 이미 ViewController 안에 view라는 객체가 존재하므로, 이름을 바꿔줘야 함
  // memory에 올라간 인스턴스가 하나의 저장속성에 담겨 있는 모습
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  
    configureUI()
  }
  
  func configureUI() {
    emailTextFieldView.backgroundColor = UIColor.darkGray
    view.addSubview(emailTextFieldView) // 이미 존재하는 view 위에 하위의 view로 넣어준다.
    
    // ⚡️ SubView의 AutoLayout 설정 (기존의 ADD NEW CONSTRAINTS)
    
    // ⭐️ 아래의 AutoLayout 설정만 하면, 화면에 보이지 않으므로, 아래의 코드를 작성한다.
    // UIView 클래스를 활용해 객체를 생성하면, 자동으로 Frame 기준으로 화면에 올라가기 때문에, 자동으로 설정해주는 기능을 꺼주는 옵션
    emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
    
    // (Roughly) left anchor
    emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    // (Roughly) right anchor
    emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    
    emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    
    emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true // 높이는 기준이 없으므로, constant값만 넣어주도록

  }


}

