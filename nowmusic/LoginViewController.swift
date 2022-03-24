//
//  LoginViewController.swift
//  nowmusic
//
//  Created by YOONJONG on 2022/03/07.
//

import UIKit

class LoginViewController: UIViewController {

   
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.isEnabled = false
        self.configureInputField()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if idTextField.text != "" && passwordTextField.text != ""  {
            guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
            mainViewController.id = idTextField.text!
            mainViewController.password = passwordTextField.text!
            print("보내는 ID, PW : \(mainViewController.id), \(mainViewController.password)")
            sendString()
            
        }
    }
    
    func sendString(){
        // guard let url = URL(string: "http://192.168.0.11:8080/db/user/memberrs/login?userId=yoonjong&password=1234")
        if let url = URL(string: "http://192.168.0.11:8080/db/user/members/login?userId=\(idTextField.text!)&password=\(passwordTextField.text!)"){
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                guard let response = response else { return }
//                print("data : \(data)")
                print("response: \(response)")
                if let httpResponse = response as? HTTPURLResponse{
                    let httpStatusCode = httpResponse.statusCode
                    if httpStatusCode == 200 {
                        DispatchQueue.main.sync{
                            guard let mainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") else { return }
                            self.navigationController?.pushViewController(mainTabBarController, animated: true)
                        }
                    }
                    else {
                        print("유저 정보가 없습니다")
                    }
                    
                }
            }.resume()
        }
    }
    private func configureInputField(){
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.idTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
}
extension LoginViewController{
    @objc func textFieldDidChange(_ sender:Any?){
        if self.idTextField.text != "" && self.passwordTextField.text != "" {
            self.loginButton.isEnabled = true
        }
        else {
            self.loginButton.isEnabled = false
        }
    }
}
