//
//  Post.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 10/22/16.
//  Copyright © 2016 Pritesh Parekh. All rights reserved.
//


import UIKit

class Post: NSObject {
    
    
    var username: String!
    var likes: Int!
    var pathToImage: String!
    var userID: String!
    var postID: String!
   var profile : String!
    var caption :String!
    var postedTime: String!
   
    
      var peopleWhoLike: [String] = [String]()
    
}
