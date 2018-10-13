//
//  TableViewController.swift
//  EmojiDictionaryProject
//
//  Created by Timur Saidov on 12/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

// Present Modally - сигвей, использующий, когда экран появляется, а затем возвращается на предыдущий. Show - сигвей, когда экран не возвращается, а идет далее вглубь.

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
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            emoji.remove(at: indexPath.row)
//            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade) // Удаляется ячейка, и вызываются 2 метода: numberOfSections и tableView(numberOfRowsInSection), чтобы заново перерисовать ячейку. Если удаление из массива будет позже этого метода, возникнет ошибка, так как экземпляров модели будет по-прежнему n, а ячеек n-1.
//            tableView.endUpdates()
        }
    }
    
    // MARK:  - Table view delegate
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = self.emoji[indexPath.row]
//        print("\(emoji.symbol) \(emoji.name) - \(indexPath)") 
//    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) // Желательно всегда вызывать родительский, когда есть переопределение override.
        
        if segue.identifier == "EditEmojiSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let emoji = self.emoji[indexPath.row]
                guard let navigationController = segue.destination as? UINavigationController else { return }
                guard let addEditTableViewController = navigationController.viewControllers.first as? AddEditTableViewController else { return } //  = navigationController.topViewController
                addEditTableViewController.navigationItem.title = "Edit"
                addEditTableViewController.emoji = emoji
            }
        }
    }
    
    @IBAction func unwindToTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        
        guard let sourceViewController = segue.source as? AddEditTableViewController else { return }
        
        guard let newOrEditingEmoji = sourceViewController.emoji else { return }
        
        // Если выбрана определенная строка, то ячейка перезаписывается - это изменение (Edit), иначе (если нажимается плюс (Add), indexPathForSelectedRow = nil), то  создается новая ячейка с новыми данными. Возможен и другой вариант проверки: если title AddEditTableViewController Edit, то надо перезаписывать ячейку, а если title = Add, то создавать новую ячейку.
//        if sourceViewController.title == "Edit" {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emoji[selectedIndexPath.row] = newOrEditingEmoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade) // Обновление только выбранной ячейки.
//        } else if sourceViewController.title = "Add" {
        } else {
            emoji.append(newOrEditingEmoji)
            let newIndexPath = IndexPath(row: emoji.count - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .fade) // Добавление в конец таблицы (конец таблицы, так как newIndexPath.row = emoji.count-1) новой ячейки с  новым элементом.
        }
    }
}
