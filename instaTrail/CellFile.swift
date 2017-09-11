//
//  CellFile.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/24/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//

import UIKit
import Firebase


class CellFile: UITableViewCell {

    @IBOutlet weak var profileImageShow: UIImageView!
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var usernameShow: UILabel!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var unlike: UIButton!
 
    @IBOutlet weak var dateTime: UILabel!
       
     var postID: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func like(_ sender: Any) {
       
        self.like.isEnabled = false
        let ref = Database.database().reference()
        let keyToPost = ref.child("Posts").childByAutoId().key
        print(postID)
        ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
              if let post = snapshot.value as? [String : AnyObject] { print("34")
                let updateLikes: [String : Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]
                ref.child("Posts").child(self.postID).updateChildValues(updateLikes, withCompletionBlock: { (error, reff) in
                     print("35")
                    if error == nil {
                        print("36")
                        ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peopleWhoLike"] as? [String : AnyObject] {
                                    print("69")
                                    let count = likes.count
                                    self.likes.text = "\(count) Likes"
                                    
                                    let update = ["likes" : count]
                                    ref.child("Posts").child(self.postID).updateChildValues(update)
                                    
                                    self.like.isHidden = true
                                    self.unlike.isHidden = false
                                    self.like.isEnabled = true
                                }
                            }
                        })
                    }
                })
            }
            
            
        })
        
        ref.removeAllObservers()
        
        
    }
    
    
    
    

    
    
    @IBAction func unlike(_ sender: Any) {
        
        self.unlike.isEnabled = false
        let ref = Database.database().reference()
        
        
        ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties = snapshot.value as? [String : AnyObject] { print("91")
                if let peopleWhoLike = properties["peopleWhoLike"] as? [String : AnyObject] {
                    for (id,person) in peopleWhoLike { print("92")
                        if person as? String == Auth.auth().currentUser!.uid {
                            ref.child("Posts").child(self.postID).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, reff) in
                                if error == nil { print("93")
                                    ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                        if let prop = snap.value as? [String : AnyObject] {
                                            if let likes = prop["peopleWhoLike"] as? [String : AnyObject] { print("94")
                                                let count = likes.count
                                                self.likes.text = "\(count) Likes"
                                                ref.child("Posts").child(self.postID).updateChildValues(["likes" : count])
                                            }else {
                                                self.likes.text = "0 Likes"
                                                 print("95")
                                                ref.child("Posts").child(self.postID).updateChildValues(["likes" : 0])
                                            }
                                        }
                                    })
                                }
                            })
                            
                            self.like.isHidden = false
                            self.unlike.isHidden = true
                            self.unlike.isEnabled = true
                            break
                            
                        }
                    }
                }
            }
            
        })
        ref.removeAllObservers()
    }

    
   

}
