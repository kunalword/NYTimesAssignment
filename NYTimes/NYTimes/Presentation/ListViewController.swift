//
//  ListViewController.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit


var dataListArray = NSMutableArray()
var selectedIndex = NSInteger()

class ListViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    //MARK:- Declare Varibales
    let cellReuseIdentifier_ListTableViewCell               = "ListTableViewCellID"
    
    let BaseURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=9jYmLnEK4jb5jfizHzSngaZ40aGlwkn1"
    
    @IBOutlet weak var loadingView: UIView!
    
    //MARK:- Declare IBOutlet
    @IBOutlet weak var aTableView: UITableView!
    
    
    override func viewDidLoad() {
        customWebservice()
        initializeCell()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }
    
    
    
    
    func initializeCell() {
        HelperClass().initializeCellWithIdentifier(aTableView: aTableView, nibName: "ListTableViewCell", cellIdentifier: cellReuseIdentifier_ListTableViewCell)
        
        //HelperClass().initializeCell(aTableView: recentTableView,cellIdentifier:"RecentChatCell")
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        // If you're serving data from an array, return the length of the array:
        return dataListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
    //MARK: - cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier_ListTableViewCell, for: indexPath) as! ListTableViewCell
        
        //get valuse from array to dic
        let resultsDic = dataListArray[indexPath.row] as! NSDictionary
        
        let titleStr = resultsDic["title"] as! String
        let detailsStr = resultsDic["abstract"] as! String
        let dateStr = resultsDic["published_date"] as! String
        
        
        
        cell.cellTitleLabel?.text = String(describing: titleStr)
        cell.cellDesciptionLabel?.text = String(describing: detailsStr)
        cell.cellDateLabel?.text = String(describing: dateStr)
              
        
        
        
        
        
        let mediaArray = resultsDic["media"] as! NSArray
        let mediaDic = mediaArray[0] as! NSDictionary
        let media_metadataArray = mediaDic["media-metadata"] as! NSArray
        let media_metadataDic = media_metadataArray[0] as! NSDictionary
        
        let imageURL = media_metadataDic["url"] as! String
        

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURL)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.cellImageView.image = UIImage(data: data!)
            }
        }
        
        
        
        
        return cell
    }
    
    //MARK: - did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchToDetailsScreen(index: indexPath.row)
        
        
    }
    
    func switchToDetailsScreen(index : NSInteger) {
        selectedIndex = index
        let DetailsViewControllerObj = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
               self.navigationController?.pushViewController(DetailsViewControllerObj, animated: false)
    }
    
    
    
    
    func customWebservice() {

        self.loadingView.isHidden = false
        
        let isConnect = InternetHandlerClass.isConnectedToNetwork()
        print(isConnect)
        if isConnect {
            
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            let url = URL(string: BaseURL)!
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                // Parse the data in the response and use it
                
                
                self.loadingView.isHidden = true
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    print("json = ",json as Any)
                    
                    let aDataArray = json.object(forKey: "results") as! NSArray
                    print(aDataArray)
                    
                    
                    dataListArray = aDataArray.mutableCopy() as! NSMutableArray
                  
                                      
                    
                    self.aTableView.reloadData()
                } catch let error as NSError {
                    //                let JSONResponse = [Str_Error: error.localizedDescription]
                    //                completionHandler(JSONResponse as AnyObject)
                      print("error = ",error )
                }
                
                
                
                //            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                
                
            })
            task.resume()
            
            
            
        }
    }
    
    
}
