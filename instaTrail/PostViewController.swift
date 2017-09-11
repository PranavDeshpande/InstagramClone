//
//  PostViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/25/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var imagePost: UIImageView!
    
    @IBOutlet weak var captionText: UITextView!
    
    var imageFileName = " "
    
  
    @IBAction func selectImageButton(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func postButton(_ sender: Any) {
       
        
       
        
        
        if (imageFileName != " ") {
            
            let key = Database.database().reference().child("Posts").childByAutoId().key
            let date = Date()
            let calender = Calendar.current
            let hour = calender.component(.hour, from: date)
            let minutes = calender.component(.minute, from: date)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yy"
            let result = formatter.string(from: date)
            let postedTime =  ("\(result) \(hour):\(minutes)")
            
            
            
        if let Uid = Auth.auth().currentUser?.uid {

            Database.database().reference().child("users").child(Uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDict = snapshot.value as? [String:AnyObject] {
            

                    if let profile = userDict["urlToImage"] {
                       if let username = userDict["username"] {
                            if let caption = self.captionText.text {
                                let postObject: Dictionary <String,Any>  = [
                                    "post id" : key,
                                    "username" : username,
                                    "userid" : Uid,
                                    "profileImage" : profile,
                                    "postedImage" : self.imageFileName,
                                    "likes" : 0,
                                    "caption" : caption,
                                    "postedTime" : postedTime
                                ]
                                let postFeed = ["\(key)" : postObject]
                                
                                Database.database().reference().child("Posts").updateChildValues(postFeed)
                            
                                
                            

                               
                                
                                let alert = UIAlertController(title: "Success", message: "You have posted successfuly", preferredStyle: .alert)
                                let alertaction = UIAlertAction.init(title: "OK", style: .default, handler: { _ in
                                    self.navigationController?.popViewController(animated: true)
                                })
                                  alert.addAction(alertaction)
                                self.present(alert, animated: true, completion: nil)
                                
                            //    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeed")
                            //    self.present(vc!, animated: true, completion: nil)
                                

                            
                        }
                        
                        }}
                    
                }})
            } }
        
       
            else {
                let alert = UIAlertController(title: "Please Wait", message: "It is taking some time to upload", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
            
                
            }
            
            
        
    }
    
  
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagePicked = info[UIImagePickerControllerEditedImage] as? UIImage
    
        self.imagePost.image = imagePicked
        self.selectImage.isEnabled = false
        self.selectImage.isHidden = true
        uploadImage(imagePost: imagePicked!)
        dismiss(animated: true, completion: nil)
        }
 
    
   
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        }

    
   
    
    
    func uploadImage(imagePost : UIImage) {
        
        var randomName = randomString(length: 10)
        var imageData = UIImageJPEGRepresentation(imagePost, 1.0)
        let uploadRef = Storage.storage().reference().child("images/\(randomName).jpg")
        
        let upload = uploadRef.putData(imageData!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Error uploading Image\(String(describing: error?.localizedDescription))")
            } else {
                print("Successfuly Uploaded")
                self.imageFileName = "\(randomName as String).jpg"
                
            }
        
    }
        }
    
  
    
    
    
    func randomString(length : Int) -> NSString {
        let character : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        
        let random : NSMutableString = NSMutableString(capacity: length)
        
        for _ in 0..<length {
            
            let len = UInt32(character.length)
            let ran = arc4random_uniform(len)
            random.appendFormat("%C", character.character(at: Int(ran)))
        }
        return random
        }

    
    
    
    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
