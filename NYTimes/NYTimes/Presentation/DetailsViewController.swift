//
//  DetailsViewController.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    //MARK:- Declare Varibales
//    var dataListArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataListArray)
        print(selectedIndex)
        // Do any additional setup after loading the view.
        
        
        
        
        //get valuse from array to dic
               let resultsDic = dataListArray[selectedIndex] as! NSDictionary
               
               let titleStr = resultsDic["title"] as! String
               let detailsStr = resultsDic["abstract"] as! String
               let dateStr = resultsDic["published_date"] as! String
               
               
               
               titleLabel?.text = String(describing: titleStr)
               detailsTextView?.text = String(describing: detailsStr)
             
        
               let mediaArray = resultsDic["media"] as! NSArray
               let mediaDic = mediaArray[0] as! NSDictionary
               let media_metadataArray = mediaDic["media-metadata"] as! NSArray
               let media_metadataDic = media_metadataArray[0] as! NSDictionary
               
               let imageURL = media_metadataDic["url"] as! String
               

               DispatchQueue.global().async {
                   let data = try? Data(contentsOf: URL(string: imageURL)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                   DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                   }
               }
               
 
               
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
