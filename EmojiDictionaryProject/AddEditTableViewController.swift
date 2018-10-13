//
//  AddEditTableViewController.swift
//  EmojiDictionaryProject
//
//  Created by Timur Saidov on 13/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    // Метод, вызывающийся каждый раз, когда произошло изменение в следующих textField (Event: Editing Changed): symbolTextField, nameTextField, descriptionTextField и usageTextField.
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    var emoji: Emoji?
//    var emoji: Emoji = Emoji(symbol: "", name: "", description: "", usage: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        updateSaveButtonState()
    }
    
    func updateUI() {
        guard let emoji = emoji else { return }
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        usageTextField.text = emoji.usage
    }

    func updateSaveButtonState() {
        // Поскольку textField.text может быть nil, необходимо воспользоваться оператором, замещающим nil.
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
//        if symbolText != "" && nameText != "" && descriptionText != "" && usageText != "" {
        if !symbolText.isEmpty && symbolText.count == 1 && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty {
                saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
//        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) // Желательно всегда вызывать родительский, когда есть переопределение override.
        
        if segue.identifier == "saveUnwind" {
            guard let symbol = symbolTextField.text else { return }
            guard let name = nameTextField.text else { return }
            guard let description = descriptionTextField.text else { return }
            guard let usage = usageTextField.text else { return }
            
            emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        }
    }
}
