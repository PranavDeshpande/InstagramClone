//
//  SignUpViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/28/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SVProgressHUD

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passlabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var gotoSignIn: UIButton!
    
    
     var userStorage: StorageReference!
    
    
 
    //      Select Profile Image Button works Here
    
    @IBAction func chooseProfileButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagePicked = info[UIImagePickerControllerEditedImage] as? UIImage
        self.profileImage.isHidden = false
        self.profileImage.image = imagePicked
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
 
    


// Create Account Button works Here


    @IBAction func signUpButton(_ sender: Any) {
        
        guard email.text != "", password.text != "",  fullname.text != "", username.text != ""  else {return}
        
        SVProgressHUD.show()
        
        
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
               
                if let error = error {
                    SVProgressHUD.dismiss()
                    print(error.localizedDescription)
                }
                
                    if let user = user {
                        
                        
                        let imageRef = self.userStorage.child("\(user.uid).jpg")
                        let data = UIImageJPEGRepresentation(self.profileImage.image!, 0.5)
                        
                        
                        let uploadTask = imageRef.putData(data!, metadata: nil, completion: { (metadata, err) in
                            
                            if err != nil {
                                print(err!.localizedDescription)
                            }
                            
                            imageRef.downloadURL(completion: { (url, er) in
                                if er != nil {
                                    print(er!.localizedDescription)
                                }
                                

                                if let url = url {
                                    
                                    let userInfo: [String : Any] = ["uid" : user.uid,
                                                                    "full name" : self.fullname.text!,
                                                                    "email" : self.email.text!,
                                                                    "username" : self.username.text!,
                                                                    "password" : self.password.text!,
                                                                    "urlToImage" : url.absoluteString]
                                    
                                    Database.database().reference().child("users").child(user.uid).setValue(userInfo)
                                    
                                    
                                    SVProgressHUD.dismiss()
                                    
                                    let alert = UIAlertController(title: "Success", message: "Account Created", preferredStyle: .alert)
                                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                        
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier:"NewsFeed")
                                        self.present(VC!, animated: true, completion: nil)
                                    }
                                    )
                                    alert.addAction(alertaction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    
                                    
                                    
                                    
                                }
                            })
                        })
                      
                        
                        uploadTask.resume()
                        
            }
                
        }
       
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.isHidden = true
        
        userStorage = Storage.storage().reference(forURL: "gs://instatrail-23057.appspot.com").child("User Profile Images")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

}









