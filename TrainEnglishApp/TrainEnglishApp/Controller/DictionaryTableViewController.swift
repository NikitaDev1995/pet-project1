//
//  DictionaryTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit
import CoreData

class DictionaryTableViewController: UITableViewController {

    //MARK: - Properites
    //Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Data for the table
    var words: [WordEntity]?
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DictionaryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DictionaryCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tabBarItem.title = NSLocalizedString("TabBarController.BarItem.Title", comment: "")
        
        //Get items from CoreData
        fetchWords()
    }
    
    //MARK: - Methods
    func fetchWords() {
        //Fetch the data from CoreData to display in tableview
        do {
          words = try context.fetch(WordEntity.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    @IBAction func unwindDictionaryTableViewController(segue: UIStoryboardSegue) {
        
    }
}

//MARK: - Extension DictionaryTableViewController (UITableVIewDelegate, UITableViewDataSource)
extension DictionaryTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryCell", for: indexPath) as? DictionaryTableViewCell
        let word = words?[indexPath.row]
        cell?.englishWordOutlet.text = word?.englishWord
        cell?.russianWordOutlet.text = word?.russianWord
        
        return cell ?? UITableViewCell()
    }
}
