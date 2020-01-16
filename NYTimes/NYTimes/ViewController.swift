//
//  ViewController.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/2020.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var aTableViewCell: UITableViewCell!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.perform(#selector(self.switchToListScreen), with: nil, afterDelay: 0.01)
    }
    
    
    @objc func switchToListScreen() {
        let ListViewControllerObj = ListViewController(nibName: "ListViewController", bundle: nil)
        self.navigationController?.pushViewController(ListViewControllerObj, animated: false)
    }
    
    
    
    
    
    
   
    
    
}

