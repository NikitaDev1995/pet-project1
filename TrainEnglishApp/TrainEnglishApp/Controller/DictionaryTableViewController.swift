//
//  DictionaryTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit
import CoreData

class DictionaryTableViewController: UITableViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    //MARK: - Properites
    //Data for the table
    private var words: [WordEntity] = []
    private var filteredWords: [WordEntity] = []
    private var isSearching: Bool = false
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DictionaryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DictionaryCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        searchBarOutlet.delegate = self
        //Получаем данные из CoreData
        fetchWords()
        configureDictionaryTableViewController()
    }
    
    //MARK: - Methods
    private func fetchWords() {
        //Получаем данные из базы данных CoreData и отображаем в таблице
        do {
            //Сортируем таблицу в английском алфавитном порядке
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
    
    private func configureDictionaryTableViewController() {
        navigationItem.title = NSLocalizedString("DictionaryTableViewController.NavigationItem.Title", comment: "")
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func deleteWord(at indexPath: IndexPath) {
        let filteredIndex = indexPath.row
        let originalIndex = words.firstIndex(of: filteredWords[filteredIndex])
        
        filteredWords.remove(at: filteredIndex)
        if let originalIndex = originalIndex {
            let wordToRemove = self.words[originalIndex]
            //Удаляем слово
            AppDelegate.context.delete(wordToRemove)
        }
        //Сохраняем данные
        do{
            try AppDelegate.context.save()
        }
        catch {
            
        }
        //Обновляем данные
        self.fetchWords()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - @IBActions
    @IBAction func unwindDictionaryTableViewController(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveWord" else {return}
        let sourceViewController = segue.source as! AddEditWordTableViewController
        //Изменяем существующее слово
        if let word = sourceViewController.word {
            word.englishWord = sourceViewController.englishWordTextFieldOutlet.text
            word.russianWord = sourceViewController.russianWordTextFieldOutlet.text
            word.wordLevel = sourceViewController.englishLevelWordSegmentedControllerOutlet.titleForSegment(at: sourceViewController.englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex)
            if let image = sourceViewController.wordImageViewOutlet.image {
                if let imageData = image.pngData() {
                    word.wordImage = imageData
                }
            }

            //Сохраняем данные
            do {
                try AppDelegate.context.save()
            }
            catch {
                
            }
            //Обновляем данные
            fetchWords()
        } else {
            //Создаем новое слово
            let newWord = WordEntity(context: AppDelegate.context)
            newWord.englishWord = sourceViewController.englishWordTextFieldOutlet.text
            newWord.russianWord = sourceViewController.russianWordTextFieldOutlet.text
            newWord.wordLevel = sourceViewController.englishLevelWordSegmentedControllerOutlet.titleForSegment(at: sourceViewController.englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex)
            if let image = sourceViewController.wordImageViewOutlet.image {
                if let imageData = image.pngData() {
                    newWord.wordImage = imageData
                }
            }
            //Сохраняем данные
            do {
                try AppDelegate.context.save()
            } catch {
                
            }
            //Обновляем данные
            fetchWords()
        }
    }
}

//MARK: - Extension DictionaryTableViewController (UITableVIewDelegate, UITableViewDataSource)
extension DictionaryTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredWords.count : words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryCell", for: indexPath) as? DictionaryTableViewCell
        
        if isSearching {
            let filteredWord = filteredWords[indexPath.row]
            
            cell?.englishWordOutlet.text = filteredWord.englishWord
            cell?.russianWordOutlet.text = filteredWord.russianWord
            cell?.englishWordLevelOutlet.text = filteredWord.wordLevel
            return cell ?? UITableViewCell()
        } else {
            let word = words[indexPath.row]
            
            cell?.englishWordOutlet.text = word.englishWord
            cell?.russianWordOutlet.text = word.russianWord
            cell?.englishWordLevelOutlet.text = word.wordLevel
            return cell ?? UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            let filteredWord = filteredWords[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addEditTableViewController = storyboard.instantiateViewController(identifier: "AddEditWordTableViewController") as? AddEditWordTableViewController
            addEditTableViewController?.word = filteredWord
            self.navigationController?.pushViewController(addEditTableViewController ?? UITableViewController(), animated: true)
        } else {
            let word = words[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addEditTableViewController = storyboard.instantiateViewController(identifier: "AddEditWordTableViewController") as? AddEditWordTableViewController
            addEditTableViewController?.word = word
            self.navigationController?.pushViewController(addEditTableViewController ?? UITableViewController(), animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isSearching {
                
                deleteWord(at: indexPath)
                
                
            } else {
                let wordToRemove = self.words[indexPath.row]
                //Удаляем слово из отображаемой таблицы
                words.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                //Удаляем слово из CoreData
                AppDelegate.context.delete(wordToRemove)
                //Сохраняем данные
                do{
                    try AppDelegate.context.save()
                }
                catch {
                    
                }
                //Обновляем данные
                self.fetchWords()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - Extension DictionaryTableViewController (UISearchBarDelegate)
extension DictionaryTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredWords.removeAll()
        
        guard searchText != "" || searchText != " " else {return}
        
        if searchBar.text == "" || searchBar.text == " " {
            isSearching = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            isSearching = true
            let searchText = searchBar.text ?? ""
            filteredWords = words.filter { word in
                return word.russianWord!.lowercased().contains(searchText.lowercased()) ||
                word.englishWord!.lowercased().contains(searchText.lowercased())
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
