//
//  SignupViewController.swift
//  nowmusic
//
//  Created by YOONJONG on 2022/03/14.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completeButton.isEnabled = false
        self.configureInputField()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        if idTextField.text != "" && passwordTextField.text != "" && ageTextField.text != "" && nameTextField.text != "" && genreTextField.text != "" {
            
            signupLogic()
            
        }
        
    }
    
    
    private func signupLogic(){
        print(idTextField.text!, passwordTextField.text!, nameTextField.text!, ageTextField.text!, genreTextField.text!)
        let dic:Dictionary = ["userId" : idTextField.text!, "password" : passwordTextField.text!,"name" : nameTextField.text!, "age" :  ageTextField.text!, "favoriteGenre" : genreTextField.text!]
        
        
        guard let url = URL(string: "http://192.168.0.11:8080/db/user/members") else {
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch { print(error.localizedDescription) }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
        
        // URLSession으로 데이터를 서버에 전송
        print("URLSession 진입")
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            print("회원가입 전송완료")
            if let httpResponse = response as? HTTPURLResponse{
                let httpStatusCode = httpResponse.statusCode
                let successRange = (200..<300)
                print("--> statuscode: \(httpStatusCode)")
                if successRange.contains(httpStatusCode) {
                    DispatchQueue.main.async{
                        let alert = UIAlertController(title: "회원가입이 성공했습니다.", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 3
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                    print("새로운 아이디 등록이 성공했습니다.")
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    DispatchQueue.main.async{
                        let alert = UIAlertController(title: "이미 등록된 아이디입니다.", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 3
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                    print("이미 등록된 아이디입니다.")
                    self.idTextField.text = ""
                    self.idTextField.placeholder = "다시 입력해주세요."
                }
                
            }
        }).resume()
    }
    private func configureInputField(){
        self.idTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.ageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.genreTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
}
extension SignupViewController{
    @objc func textFieldDidChange(_ sender:Any?){
        if self.idTextField.text != "" && self.passwordTextField.text != ""
            && self.ageTextField.text != ""  && self.nameTextField.text != ""
            && self.genreTextField.text != ""
        {
            self.completeButton.isEnabled = true
        }
        else {
            self.completeButton.isEnabled = false
        }
    }
}
