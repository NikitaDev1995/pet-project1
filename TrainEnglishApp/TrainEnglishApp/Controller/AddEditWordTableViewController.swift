//
//  AddEditWordTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit

class AddEditWordTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveWordButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
    
}
