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
            //Sort the tableview
            let request = WordEntity.fetchRequest() as NSFetchRequest<WordEntity>
            let sortEnglishWord = NSSortDescriptor(key: "englishWord", ascending: true)
            request.sortDescriptors = [sortEnglishWord]
            
            words = try AppDelegate.context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    @IBAction func unwindDictionaryTableViewController(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveWord" else {return}
        let sourceViewController = segue.source as! AddEditWordTableViewController
        //Change the existing word
        if var word = sourceViewController.word {
            word.englishWord = sourceViewController.englishWordTextFieldOutlet.text
            word.russianWord = sourceViewController.russianWordTextFieldOutlet.text
            //Save the data
            do {
                try AppDelegate.context.save()
            }
            catch {
                
            }
            //Re-fetch the data
            fetchWords()
        } else {
            //Create the new word
            let newWord = WordEntity(context: AppDelegate.context)
            newWord.englishWord = sourceViewController.englishWordTextFieldOutlet.text
            newWord.russianWord = sourceViewController.russianWordTextFieldOutlet.text
            //Save the data
            do {
                try AppDelegate.context.save()
            } catch {
                
            }
            //Re-fetch the data
            fetchWords()
        }
    }
}

//MARK: - Extension DictionaryTableViewController (UITableVIewDelegate, UITableViewDataSource)
extension DictionaryTableViewController {

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = words![indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addEditTableViewController = storyboard.instantiateViewController(identifier: "AddEditWordTableViewController") as? AddEditWordTableViewController
        addEditTableViewController?.word = word
        self.navigationController?.pushViewController(addEditTableViewController ?? UITableViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {
        let tralingSwipeAction = UIContextualAction(style: .destructive, title: NSLocalizedString("DictionaryTableViewController.TralingSwipe.DeleteButton", comment: "")) { action, view, completionHandler in
            //Witch word to remove
            let wordToRemove = self.words![indexPath.row]
            //Remove the word
            AppDelegate.context.delete(wordToRemove)
            //Save the data
            do{
                try AppDelegate.context.save()
            }
            catch {
                
            }
            //Re-fetch the data
            self.fetchWords()
        }
        return UISwipeActionsConfiguration(actions: [tralingSwipeAction])
    }
}
