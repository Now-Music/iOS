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
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if idTextField.text != "" && passwordTextField.text != "" && ageTextField.text != "" {
            guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
            mainViewController.id = idTextField.text
            mainViewController.password = passwordTextField.text
            sendString()
            guard let mainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") else { return }
            self.navigationController?.pushViewController(mainTabBarController, animated: true)
            
        }
    }
    
    func sendString(){
        // guard let url = URL(string: "http://192.168.0.11:8080/db/user/members/login?userId=yoonjong&password=1234")
        if let url = URL(string: "http://192.168.0.11:8080/db/user/members/login?userId=yoonjong&password=1234"){
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                guard let response = response else { return }
                print("data : \(data)")
                print("response: \(response)")
                
            }.resume()
        }
    }
}
