//
//  TableViewController.swift
//  EmojiDictionaryProject
//
//  Created by Timur Saidov on 12/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var emoji: [Emoji] = [
        Emoji(symbol: "🐸", name: "Лягушка", description: "Зелёная лягушка", usage: "Прыжки"),
        Emoji(symbol: "🐶", name: "Собака", description: "Типичный пес", usage: "Верность"),
        Emoji(symbol: "🐱", name: "Кот", description: "Милый кот", usage: "Хитрость"),
        Emoji(symbol: "🐰", name: "Кролик", description: "Ушастый кролик", usage: "Быстрота"),
        Emoji(symbol: "🐨", name: "Коала", description: "Коала", usage: "Лень"),
        Emoji(symbol: "👽", name: "Инопланетянин", description: "НЛО", usage: "Загадочность"),
        Emoji(symbol: "🐷", name: "Свинья", description: "Свинья", usage: "Грязь")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoji.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath - параметр, в котором лежат 2 значения: номер секции и номер ячейки в данной секции.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let emoji = self.emoji[indexPath.row]
        cell.update(with: emoji)
        
        return cell
    }
    
    // Метод для перетаскивания (пересортировки) ячеек на Table View (на view).
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emoji.remove(at: sourceIndexPath.row) // Удаление из массива перетаскиваемого элемента.
        emoji.insert(movedEmoji, at: destinationIndexPath.row) // Вставка его в массив на место, куда указал пользователь.
        tableView.reloadData() // Перезагрузка таблицы.
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK:  - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = self.emoji[indexPath.row]
        print("\(emoji.symbol) \(emoji.name) - \(indexPath)") 
    }
}
