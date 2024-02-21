//
//  AddEditWordTableViewController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 06.02.2024.
//

import UIKit

class AddEditWordTableViewController: UITableViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var englishWordTextFieldOutlet: UITextField!
    @IBOutlet weak var russianWordTextFieldOutlet: UITextField!
    @IBOutlet weak var englishLevelWordSegmentedControllerOutlet: UISegmentedControl!
    @IBOutlet weak var wordImageViewOutlet: UIImageView!
    @IBOutlet weak var viewForWordImageViewOutlet: UIView!
    @IBOutlet weak var addImageButtonOutlet: UIButton!
    
    //MARK: - Properties
    var word: WordEntity?
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        russianWordTextFieldOutlet.delegate = self
        englishWordTextFieldOutlet.delegate = self
        
        configureAddEditWordTableViewController()
        
        if let word {
            navigationItem.title = NSLocalizedString("AddEditWordTableViewController.NavigationItem.TitleForEditWord", comment: "")
            englishWordTextFieldOutlet.text = word.englishWord
            russianWordTextFieldOutlet.text = word.russianWord
            wordImageViewOutlet.image = UIImage(data: word.wordImage ?? Data())
            switch word.wordLevel {
            case "A0":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 0
            case "A1":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 1
            case "A2":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 2
            case "B1":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 3
            case "B2":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 4
            case "C1":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 5
            case "SE":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 6
            case "DPA":
                englishLevelWordSegmentedControllerOutlet.selectedSegmentIndex = 7
            default: break
            }
        } else {
            navigationItem.title = NSLocalizedString("AddEditWordTableViewController.NavigationItem.TitleNewWord", comment: "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSaveButtonState()
    }
    
    //MARK: - Methods
    private func configureAddEditWordTableViewController() {
        navigationItem.leftBarButtonItem?.title = NSLocalizedString("AddEditWordTableViewController.NavigationItem.CancelButton", comment: "")
        navigationItem.rightBarButtonItem?.title = NSLocalizedString("AddEditWordTableViewController.NavigationItem.SaveButton", comment: "")
        
        viewForWordImageViewOutlet.layer.cornerRadius = 10
        viewForWordImageViewOutlet.layer.borderWidth = 2
        viewForWordImageViewOutlet.layer.borderColor = UIColor.gray.cgColor
        viewForWordImageViewOutlet.clipsToBounds = true
        
        wordImageViewOutlet.clipsToBounds = true
        wordImageViewOutlet.contentMode = .scaleAspectFill
        
        addImageButtonOutlet.layer.cornerRadius = 10
        addImageButtonOutlet.layer.borderWidth = 2
        addImageButtonOutlet.layer.borderColor = UIColor.gray.cgColor
        addImageButtonOutlet.setTitle(NSLocalizedString("AddEditWordTableViewController.AddImageButtonAction.Title.Text", comment: ""), for: .normal)
        
        englishWordTextFieldOutlet.placeholder = NSLocalizedString("AddEditWordTableViewController.TableView.EnglishWordTextFieldOutlet.Placeholder", comment: "")
        russianWordTextFieldOutlet.placeholder = NSLocalizedString("AddEditWordTableViewController.TableView.RussianWordTextFieldOutlet.Placeholder", comment: "")
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButtonState = (englishWordTextFieldOutlet.text?.isEmpty == false && russianWordTextFieldOutlet.text?.isEmpty == false)
        saveButtonOutlet.isEnabled = shouldEnableSaveButtonState
    }

    //MARK: - @IBActions
    @IBAction func addImageButtonAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: NSLocalizedString("AddEditWordTableViewController.AddImageButtonAction.AlertController.Title", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: NSLocalizedString("AddEditWordTableViewController.AddImageButtonAction.AlertAction.CameraAction", comment: ""), style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: NSLocalizedString("AddEditWordTableViewController.AddImageButtonAction.AlertAction.photoLibraryAction", comment: ""), style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
}

//MARK: - Extension AddEditWordTableViewController (UITableViewControllerDataSource)
extension AddEditWordTableViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return NSLocalizedString("AddEditWordTableViewController.TableView.TitleForHeader.section[0]", comment: "")
        case 1: return NSLocalizedString("AddEditWordTableViewController.TableView.TitleForHeader.section[1]", comment: "")
        case 2: return NSLocalizedString("AddEditWordTableViewController.TableView.TitleForHeader.section[2]", comment: "")
        case 3: return NSLocalizedString("AddEditWordTableViewController.TableView.TitleForHeader.section[3]", comment: "")
        case 4: return NSLocalizedString("AddEditWordTableViewController.TableView.TitleForHeader.section[4]", comment: "")
        default:
            return ""
        }
    }
}

//MARK: - Extension AddEditWordTableViewController (UIImagePickerControllerDelegate)
extension AddEditWordTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        wordImageViewOutlet.image = selectedImage
        dismiss(animated: true)
    }
}

//MARK: - Extension AddEditWordTableViewController (UITextFieldDelegate)
extension AddEditWordTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        russianWordTextFieldOutlet.resignFirstResponder()
        englishWordTextFieldOutlet.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Проверяем, евляется ли пробел первым символом
        if range.location == 0 && string == " " {
            return false
        }
        
        // Получаем текущий текст поля ввода
        guard let currentText = textField.text else {
            return true
        }
        // Создаем новую строку, заменяя несколько пробелов на один пробел
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let finalText = updatedText.replacingOccurrences(of: "  ", with: " ")
        // Устанавливаем отфильтрованный текст обратно в поле ввода
        textField.text = finalText
        return false
    }
}

