//
//  SearchHistoryController.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/11/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit

class SearchHistoryController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "History", image: #imageLiteral(resourceName: "historyImage") , selectedImage: #imageLiteral(resourceName: "historyImage"))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }

}

extension SearchHistoryController : UITableViewDelegate{
    
}

extension SearchHistoryController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = 1
        
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = "HistoryCell"
        
        return cell
    }
}
