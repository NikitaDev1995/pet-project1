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
    @IBOutlet weak var englishLevelWordSegmentedControllerOutlet: UISegmentedControl!
    @IBOutlet weak var wordImageViewOutlet: UIImageView!
    
    //MARK: - Properties
    var word: WordEntity?
    
    //MARK: - Life scene cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        russianWordTextFieldOutlet.delegate = self
        englishWordTextFieldOutlet.delegate = self
        
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
            navigationItem.title = NSLocalizedString("AddEditWordTableViewController.NavigationItem.TitleForNewWord", comment: "")
        }
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
}

