//
//  SignInViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/25/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignInViewController: UIViewController {
    

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var userlabel: UILabel!
    @IBOutlet weak var passlabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
   
    
    @IBAction func signInButton(_ sender: Any) {
        
        var email = emailText.text
        var password = passText.text
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Incorrect Username or Password", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                
                email = " "
                password = " "
                
                let viewController = self.storyboard?.instantiateViewController(withIdentifier:"NewsFeed")
               self.present(viewController!, animated: true, completion: nil)
               
            
            }
            
        })
    

        
    }
    
      
    
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        
        if Auth.auth().currentUser != nil {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier:"NewsFeed")
        self.present(viewController!, animated: false, completion: nil)
       
    }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

