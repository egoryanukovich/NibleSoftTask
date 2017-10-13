//
//  SearchHistoryController.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/11/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit
import RealmSwift

class SearchHistoryController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "History", image: #imageLiteral(resourceName: "historyImage") , selectedImage: #imageLiteral(resourceName: "historyImage"))
    }
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var realm : Realm!
    var historyResult : Results<WeatherModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        loadData()
        
    }
    
    
    func loadData(){
        do {
            self.realm = try Realm()
            
        } catch {
            
        }
        self.historyResult = self.realm.objects(WeatherModel.self)
        print("It")
        print((self.historyResult?.last?.address!)!)
    }
    
}
//MARK:- UITableViewDelegate
extension SearchHistoryController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
}

//MARK:- UITableViewDataSource
extension SearchHistoryController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = historyResult?.count
        
        return numberOfRowsInSection!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HistoryCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        let weatherModelObject = historyResult![indexPath.row]
        
        cell.configureWithContactEntry(weatherModelObject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let searchHistoryStoryboard = UIStoryboard(name: "SearchHistory", bundle: nil)
            let historyInfoVC = searchHistoryStoryboard.instantiateViewController(withIdentifier: "historyInfoVC") as? HistoryInfoController
            historyInfoVC!.weatherModelObject = self.historyResult![indexPath.row]
            self.present(historyInfoVC!, animated: false, completion: nil)
        }
    }
}
