//
//  LikeViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 7/23/17.
//  Copyright © 2017 Pritesh Parekh. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
  
    @IBAction func goToFollowing(_ sender: Any) {
    }
    
    @IBAction func goToYou(_ sender: Any) {
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeYouCell", for: indexPath) as? LikeYouTableViewCell
        
        return cell!
    }

    
    
}
