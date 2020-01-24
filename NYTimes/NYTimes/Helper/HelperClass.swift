//
//  HelperClass.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/2020.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit
import Foundation


class HelperClass: NSObject {
    
    let Color_CircalButtonBorder = UIColor .gray
    let CircalButtonBorderWidth = 1.0
    
    //MARK: Shared Instance
    private static let _sharedInstance = HelperClass()
    class func sharedInstance() -> HelperClass {
        return _sharedInstance
    }
    
    func initializeCell (aTableView: UITableView, cellIdentifier: String) {
         aTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func initializeCellWithIdentifier (aTableView: UITableView, nibName: String, cellIdentifier: String) {
        aTableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    
    func OpenURL (_ urlStr:NSString) {
        
        let url = URL(string: urlStr as String)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    func RandomNumberGenerator (numberOfZeroes: Int) -> Double {
        let maximum = pow(10, Double(numberOfZeroes))
        return Double.random(in: 0...maximum)
    }
    
    
    
    func MakeCircalAndDrawBoderOnButton (btn: UIButton) {
        MakeCircalButton(button: btn)
        DrawBoderOnButton(button: btn)
    }
    
    func MakeCircalButton (button: UIButton) {
        let layer = button.layer
        layer.masksToBounds = true
        layer.cornerRadius = button.frame.size.height / 2
    }
    func DrawBoderOnButton (button: UIButton) {
        let layer = button.layer
        layer.borderColor = Color_CircalButtonBorder.cgColor
        layer.borderWidth = CGFloat(CircalButtonBorderWidth)

    }
    
    
    func MakeCircalAndDrawBoderOnImageView (imageView: UIImageView) {
        MakeCircalImageView(imageView: imageView)
        DrawBoderOnImageView(imageView: imageView)
    }
    
    func MakeCircalImageView (imageView: UIImageView) {
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = imageView.frame.size.height / 2
    }
    func DrawBoderOnImageView (imageView: UIImageView) {
        let layer = imageView.layer
        layer.borderColor = Color_CircalButtonBorder.cgColor
        layer.borderWidth = CGFloat(CircalButtonBorderWidth)
        
    }
    
    
    
    func getAllkeysListFromDic (dataDic : [AnyHashable: Any]) -> NSMutableArray {
        let objCMutableArray = NSMutableArray(array: Array(dataDic.keys))
        return objCMutableArray;
    }
    
   
    
    func trimWhitespaceAndNewline ( string : String) -> String {
        let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return  str
    }
    
  
    func getImageUrl(newsModel: NewsListViewModel) -> String{
            var urlString : String = ""
           if let media = newsModel.media {
               if media.count > 0 {
                   if media[0].mediaMetadata.count > 0 {
                       urlString = media[0].mediaMetadata[0].url ?? ""
                   }
               }
               print("media",urlString)

           }
           return urlString
       }

    
}

