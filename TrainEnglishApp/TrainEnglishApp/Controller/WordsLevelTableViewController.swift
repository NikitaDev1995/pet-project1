//
//  WordsLevelTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 18.02.2024.
//

import UIKit
import CoreData

class WordsLevelTableViewController: UITableViewController {
    
    //MARK: - Properties
    var totalWordArray: [WordEntity] = []
    var begineerArray: [WordEntity] = []
    var elementaryArray: [WordEntity] = []
    var preIntermediateArray: [WordEntity] = []
    var intermediateArray: [WordEntity] = []
    var uperIntermediateArray: [WordEntity] = []
    var advancedArray: [WordEntity] = []
    var stableExpressions: [WordEntity] = []
    var extraWords: [WordEntity] = []
    
    //MARK: - Scene life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWords()
        loadWordsArray()
        configureWordsLevelTableViewController()
    }
    
    //MARK: - Methods
    private func fetchWords() {
        //Получаем данные из базы данных CoreData и заполняем массив totalWordArray
        do {
            totalWordArray = try AppDelegate.context.fetch(WordEntity.fetchRequest())
        }
        catch {
            print("Something is wrong")
        }
    }
    
    private func loadWordsArray() {
        for word in totalWordArray {
            switch word.wordLevel {
            case "A0": begineerArray.append(word)
            case "A1": elementaryArray.append(word)
            case "A2": preIntermediateArray.append(word)
            case "B1": intermediateArray.append(word)
            case "B2": uperIntermediateArray.append(word)
            case "C1": advancedArray.append(word)
            case "SE": stableExpressions.append(word)
            case "DPA": extraWords.append(word)
            default: break
            }
        }
    }
    
    private func configureWordsLevelTableViewController() {
        navigationItem.title = NSLocalizedString("WordsLevelTableViewController.NavigationItem.Title", comment: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BEGINEER":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = begineerArray
            }
        case "ELEMENTARY":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = elementaryArray
            }
        case "PRE-INTERMEDIATE":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = preIntermediateArray
            }
        case "INTERMEDIATE":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = intermediateArray
            }
        case "UPER-INTERMEDIATE":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = uperIntermediateArray
            }
        case "ADVANCED":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = advancedArray
            }
        case "STABLE EXPRESSIONS":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = stableExpressions
            }
        case "DEPEND PREPOSITIONS, ADJECTIVES":
            if let auditViewController = segue.destination as? AuditViewController {
                auditViewController.wordsArray = extraWords
            }
        default: break
        }
    }
}
