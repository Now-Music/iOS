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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        if idTextField.text != "" && passwordTextField.text != "" && ageTextField.text != "" && nameTextField.text != "" && genreTextField.text != "" {
            
            signupLogic()
            self.navigationController?.popViewController(animated: true)
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
            print("전송완료")
        }).resume()
    }

}
