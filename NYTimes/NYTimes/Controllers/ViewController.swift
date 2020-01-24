//
//  ViewController.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

var newsDataListArray = [NewsListViewModel]()
var selectedIndex = NSInteger()

class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK:- Declare Varibales
    
   

    //MARK:- Declare IBOutlet
    @IBOutlet weak var loadingView: UIView!
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
        HelperClass().initializeCellWithIdentifier(aTableView: aTableView, nibName: Cells.listTableViewCell, cellIdentifier: Cells.cellReuseIdentifier_ListTableViewCell)
        
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
        return newsDataListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
    //MARK: - cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellReuseIdentifier_ListTableViewCell, for: indexPath) as! ListTableViewCell
        
        //get valuse from array to dic
        let newsList = newsDataListArray[indexPath.row]

        cell.cellTitleLabel?.text = newsList.title
        cell.cellDesciptionLabel?.text = newsList.abstract
        cell.cellDateLabel?.text = newsList.published_date
        let imageURL = self.getImageUrl(newsModel: newsList)
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
        let DetailsViewControllerObj = DetailsViewController(nibName: SegueIdentifier.showDetails, bundle: nil)
        self.navigationController?.pushViewController(DetailsViewControllerObj, animated: false)
    }
    
    
    
    func customWebservice() {
        
        self.loadingView.isHidden = false
        
        Webservice.shareInstance.getNewsArticlesData { (news, error) in
            if(error==nil) {
//                print("result .........",news ?? "")
                newsDataListArray.removeAll()
                newsDataListArray = news?.map({return NewsListViewModel(news:$0)}) ?? []
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                    self.aTableView.reloadData()
                }
            }else {
                print("result .........",news ?? "")
            }
        }
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


