//
//  AuditViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 19.02.2024.
//

import UIKit

class AuditViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var wordVerificationModeSegmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var languageBarButtonItemOutlet: UIBarButtonItem!
    @IBOutlet weak var auditStackViewOutlet: UIStackView!
    @IBOutlet weak var repeatStackViewOutlet: UIStackView!
    @IBOutlet var wordCounterLabelOutlet: [UILabel]!
    @IBOutlet var viewForWordImageOutlet: [UIView]!
    @IBOutlet var wordImageViewOutlet: [UIImageView]!
    @IBOutlet var englishWordLabelOutlet: [UILabel]!
    @IBOutlet var russianWordLabelOutlet: [UILabel]!
    @IBOutlet var checkWordButtonOutlet: [UIButton]!
    @IBOutlet var nextWordButtonOutlet: [UIButton]!
    
    //MARK: - Properties
    var wordsArray: [WordEntity] = []
    
    //MARK: - Scene life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAuditViewController()
    }
    
    //MARK: - Methods
    private func configureAuditViewController() {
        repeatStackViewOutlet.isHidden = true
        russianWordLabelOutlet[0].textColor = .red
        russianWordLabelOutlet[1].textColor = .red
        checkWordButtonOutlet[0].isEnabled = false
        wordVerificationModeSegmentedControlOutlet.isEnabled = false
        wordCounterLabelOutlet[0].text = "Осталось слов: \(wordsArray.count)"
    }
    //MARK: - @IBActions
    @IBAction func changeLanguageWordsBarButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func changeModeCheckWordsSegmentedControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func checkWordButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextWordButtonAction(_ sender: UIButton) {
        
    }
    
}
