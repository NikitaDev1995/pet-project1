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
    var repeatWordsArray: [WordEntity] = []
    var wordForRepeat: WordEntity?
    var indexForWordsArray = 0
    var indexForRepeatWordsArray = 0
    
    //MARK: - Scene life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAuditViewController()
    }
    
    //MARK: - Methods
    private func configureAuditViewController() {
        repeatStackViewOutlet.isHidden = true
        russianWordLabelOutlet.forEach { wordLabel in
            wordLabel.layer.cornerRadius = 10
            wordLabel.layer.borderWidth = 2
            wordLabel.layer.borderColor = UIColor.gray.cgColor
            wordLabel.textColor = .red
        }
        
        englishWordLabelOutlet.forEach { wordLabel in
            wordLabel.layer.cornerRadius = 10
            wordLabel.layer.borderWidth = 2
            wordLabel.layer.borderColor = UIColor.gray.cgColor
        }
        
        wordsArray.shuffle()
        checkWordButtonOutlet[0].isEnabled = false
        wordCounterLabelOutlet[0].text = "Осталось слов: \(wordsArray.count)"
    }
    //MARK: - @IBActions
    @IBAction func changeLanguageWordsBarButtonAction(_ sender: UIBarButtonItem) {
    
    }
    
    @IBAction func changeModeCheckWordsSegmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            repeatStackViewOutlet.isHidden = true
            auditStackViewOutlet.isHidden = false
        case 1:
            repeatStackViewOutlet.isHidden = false
            auditStackViewOutlet.isHidden = true
        default:
            break
        }
    }
    
    @IBAction func checkWordButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.russianWordLabelOutlet[0].textColor = .red
            if sender.titleLabel?.text == "Запомнить слово?" {
                repeatWordsArray.append(wordForRepeat ?? WordEntity())
                sender.setTitle("Проверить слово", for: .normal)
                sender.isEnabled = false
            } else {
                sender.setTitle("Запомнить слово?", for: .normal)
            }
        case 1:
            self.russianWordLabelOutlet[1].textColor = .red
        default:
            break
        }
    }
    
    @IBAction func nextWordButtonAction(_ sender: UIButton) {
        guard wordsArray.count != 0 else {return}
        
        checkWordButtonOutlet[0].isEnabled = true
        switch sender.tag {
        case 0:
            checkWordButtonOutlet[0].setTitle("Проверить слово", for: .normal)
            russianWordLabelOutlet[0].textColor = .white
            if indexForWordsArray < wordsArray.count {
                let checkWord = wordsArray[indexForWordsArray]
                wordCounterLabelOutlet[0].text = "Осталось слов: \(wordsArray.count - indexForWordsArray)"
                englishWordLabelOutlet[0].text = checkWord.englishWord
                russianWordLabelOutlet[0].text = checkWord.russianWord
                wordImageViewOutlet[0].image = UIImage(data: checkWord.wordImage ?? Data())
                wordForRepeat = checkWord
                indexForWordsArray += 1
            } else {
                checkWordButtonOutlet[0].isEnabled = false
                repeatWordsArray.removeAll()
                indexForWordsArray = 0
                wordCounterLabelOutlet[0].text = "Осталось слов: 0"
                englishWordLabelOutlet[0].text = "Все слова повторены"
                russianWordLabelOutlet[0].text = "All words were checked"
                wordsArray.shuffle()
            }
        case 1:
            guard repeatWordsArray.count != 0 else {return}
            russianWordLabelOutlet[1].textColor = .white
            if indexForRepeatWordsArray < repeatWordsArray.count {
                let repeatWord = repeatWordsArray[indexForRepeatWordsArray]
                wordCounterLabelOutlet[1].text = "Осталось слов: \(repeatWordsArray.count - indexForRepeatWordsArray)"
                englishWordLabelOutlet[1].text = repeatWord.englishWord
                russianWordLabelOutlet[1].text = repeatWord.russianWord
                wordImageViewOutlet[1].image = UIImage(data: repeatWord.wordImage ?? Data())
                indexForRepeatWordsArray += 1
            } else {
                indexForRepeatWordsArray = 0
                wordCounterLabelOutlet[1].text = "Осталось слов: 0"
                englishWordLabelOutlet[1].text = "Все слова повторены"
                russianWordLabelOutlet[1].text = "All words were checked"
            }
        default:
            break
        }
    }
    
}
