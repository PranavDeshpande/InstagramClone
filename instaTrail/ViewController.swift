//
//  ViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/22/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
         var following = [String]()
   var posts = [Post]()
    
    @IBAction func logoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignIn")
            present(vc!, animated: true, completion: nil)
            
        }
        catch {
            print("Error logging out")
        }
        
        
    }
    
   
    
    func loadData(){
        
        let ref = Database.database().reference()
      //  let date = Storage.
        
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            
            let users = snapshot.value as! [String : AnyObject]
            
            for (_,value) in users {
                if let uid = value["uid"] as? String {
                    if uid == Auth.auth().currentUser?.uid {
                        
                        if let followingUsers = value["following"] as? [String : String]{
                            for (_,user) in followingUsers{
                                self.following.append(user)
                            }
                        }
                        self.following.append(Auth.auth().currentUser!.uid)
                        
                        ref.child("Posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                            
                            
                            let postsSnap = snap.value as! [String : AnyObject]
                            
                            for (_,post) in postsSnap {
                                if let userID = post["userid"] as? String {
                                    for each in self.following {
                                        if each == userID {
                                            let posst = Post()
                                            
                                            print("1")
                                            if let username = post["username"] as? String, let likes = post["likes"] as? Int, let pathToImage = post["postedImage"] as? String, let postID = post["post id"] as? String, let profile = post["profileImage"] as?String, let caption = post["caption"] as? String, let postedTime = post["postedTime"] as? String  {
                                               print("2")
                                                posst.username = username
                                                posst.likes = likes
                                                posst.pathToImage = pathToImage
                                                posst.postID = postID
                                                posst.userID = userID
                                                posst.profile = profile
                                                posst.caption = caption
                                                posst.postedTime = postedTime
                                                
                                                if let people = post["peopleWhoLike"] as? [String : AnyObject] { print("55")
                                                    for (_,person) in people { print("60")
                                                        posst.peopleWhoLike.append(person as! String)
                                                    }
                                                }

                                                
                                                
                                                
                                                self.posts.append(posst)
                                                print("3")
                                            }
                                        }
                                    }
                                    
                                    self.tableView.reloadData()
                                    if self.posts.count == 0 {
                                        self.tableView.isHidden = true
                                    }
                                    else {
                                        
                                    }
                                    print("Hi")

                                }
                            }
                        })
                    }
                }
            }
            
        })
        ref.removeAllObservers()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as?CellFile
        
        
       
        
         cell?.caption.text = self.posts[indexPath.row].caption
    
        cell?.likes.text = "\(self.posts[indexPath.row].likes!) Likes"
        
        
        cell?.usernameShow.text = self.posts[indexPath.row].username
        
        cell?.dateTime.text = self.posts[indexPath.row].postedTime
        
        
        
        if let imageLink = self.posts[indexPath.row].profile {
        cell?.profileImageShow.sd_setImage(with: URL(string: imageLink ))
        }
       
        
        
       
        if let imageName = self.posts[indexPath.row].pathToImage {
           
        let imageRef = Storage.storage().reference().child("images/\(String(describing: imageName))")
        imageRef.getData(maxSize: 25*1024*1024, completion:  { (data, error) -> Void in
            if error == nil {
                
            let image = UIImage(data: data!)
                cell?.pictures.image = image
            } else {
                print("Error Downloading Image\(String(describing: error?.localizedDescription))")
                
            }
        })}
        
          cell?.postID = self.posts[indexPath.row].postID
    
        
        
        for person in self.posts[indexPath.row].peopleWhoLike { print("66")
            if person == Auth.auth().currentUser!.uid {
                print("77")
                cell?.like.isHidden = true
                cell?.unlike.isHidden = false
                break
            }
        }

        
      
        
        return cell!
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}













