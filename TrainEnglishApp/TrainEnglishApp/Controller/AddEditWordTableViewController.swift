//
//  AddEditWordTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit

class AddEditWordTableViewController: UITableViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var englishWordTextFieldOutlet: UITextField!
    @IBOutlet weak var russianWordTextFieldOutlet: UITextField!
    
    //MARK: - Properties
    var word: WordEntity?
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let word {
            englishWordTextFieldOutlet.text = word.englishWord
            russianWordTextFieldOutlet.text = word.russianWord
        }
    }

}
