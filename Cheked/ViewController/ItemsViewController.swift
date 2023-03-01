//
//  NewViewController.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 12.02.2023.
//

import UIKit
import Hero
import RealmSwift
import SwipeCellKit

class ItemsViewController: UIViewController {
    
    let realm = try! Realm()
    var items: Results<Item>?
    
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topBarTitle: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIView!
    var itemCellColor = UIColor()
    
    var selectedCategory: Category?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goBackToCategoriesVC))
        backButton.addGestureRecognizer(gesture)
        
        let addButtonGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonPressed))
        addButton.addGestureRecognizer(addButtonGesture)
    }
    
    
    override func viewWillLayoutSubviews() {
        loadItems()
        tableView.reloadData()
    }
    
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    
    func deleteData(_ item: Item) {
        do {
            try self.realm.write {
                self.realm.delete(item)
            }
        } catch {
            print("Error \n Realm Delete Data")
        }
    }
    
    
    @objc func goBackToCategoriesVC() {
        self.dismiss(animated: true)
    }
    
    
    @objc func addButtonPressed() {
        performSegue(withIdentifier: "toAddItem", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddItem" {
            let destinationVC = segue.destination as! AddItemViewController
            destinationVC.textFieldBackgroundColor = itemCellColor
            destinationVC.selectedCategory = self.selectedCategory
        }
    }
}


//MARK: - TableView Delegate, DataSource
extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
        
        cell.delegate = self
        
        if let item = items?[indexPath.row] {
            cell.backgroundCard.backgroundColor = itemCellColor
            cell.itemTitle.text = item.title
            cell.checkmark.isHidden = item.cheked ? false : true
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items?[indexPath.row] {
            do {
                try self.realm.write {
                    item.cheked = !item.cheked
                    self.tableView.reloadData()
                }
            } catch {
            }
        }
    }
}


//MARK: - SwipeCellKitDelegate
extension ItemsViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in

            
            let transition = ScaleTransition(duration: 1, initialScale: 0)
            action.transitionDelegate = transition

            if let item = self.items?[indexPath.row] {
                self.deleteData(item)
            }
        }
        
        deleteAction.textColor = .red
        deleteAction.title = nil
        deleteAction.backgroundColor = backgroundView.backgroundColor
        deleteAction.image = UIImage(named: "backButton")

        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructiveAfterFill
        options.backgroundColor = backgroundView.backgroundColor

        return options
    }
}

