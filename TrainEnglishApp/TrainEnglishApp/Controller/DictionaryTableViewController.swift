//
//  DictionaryTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit

class DictionaryTableViewController: UITableViewController {

    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DictionaryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DictionaryCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tabBarItem.title = NSLocalizedString("TabBarController.BarItem.Title", comment: "")
    }
}

//MARK: - Extension DictionaryTableViewController (UITableVIewDelegate, UITableViewDataSource)
extension DictionaryTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryCell", for: indexPath)
        return cell
    }
}
