//
//  SearchViewController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 7/23/17.
//  Copyright © 2017 Pritesh Parekh. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var arr : [String] = ["message", "Like1", "Home"]
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
        let itemSize = UIScreen.main.bounds.width/3 - 10
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        
        collectionView.collectionViewLayout = layout
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellofSearch", for: indexPath) as! CollectionViewCellSearch
            
            
        cell.SearchImages.image = UIImage(named: arr[indexPath.row])
        
        return cell
    }

    
   
  

}
