//
//  CategoryViewController.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 12.02.2023.
//

import UIKit
import Hero
import RealmSwift
import SwipeCellKit


class CategoryViewController: UIViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarTitle: UILabel!
    
    var itemCellColor = UIColor()
    var itemCellTextColor = UIColor()
    
    var selectedIndex = Int()
    var selectedTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        loadData()
    }
    
    
    func loadData() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    func deleteData(_ category: Category) {
        do {
            try self.realm.write {
                self.realm.delete(category)
            }
        } catch {
            print("Error \n Realm Delete Data")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItems" {
            let destinationVC = segue.destination as! ItemsViewController
            destinationVC.view.backgroundColor = .white
            destinationVC.backgroundView.backgroundColor = itemCellColor
            destinationVC.itemCellColor = itemCellTextColor
            destinationVC.backgroundView.hero.id = String(selectedIndex)
            destinationVC.topBarTitle.text = selectedTitle
            destinationVC.selectedCategory = categories?[selectedIndex]
        }
    }
}


//MARK: TableViewDelegate
extension CategoryViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            
            let cell = tableView.cellForRow(at: indexPath)! as! AddCategoryTableViewCell
            cell.addCategoryLabel.isHidden = true
            
            self.performSegue(withIdentifier: "toAdd", sender: self)
            
        } else {
            
            let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            cell.categoryName.isHidden = true
            
            itemCellColor = UIColor(hue: CGFloat(indexPath.row) / 20, saturation: 0.4, brightness: 1, alpha: 1)
            itemCellTextColor = UIColor(hue: CGFloat(indexPath.row) / 20, saturation: 0.5, brightness: 0.7, alpha: 1)
            
            self.selectedTitle = categories![indexPath.row].title
            self.selectedIndex = indexPath.row
            
            self.performSegue(withIdentifier: "toItems", sender: self)
        }
    }
}


//MARK: TableViewDataSouce
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categoryCount = categories?.count {
            return categoryCount + 1
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCategoryCell", for: indexPath) as! AddCategoryTableViewCell
            
            cell.addCategoryLabel.isHidden = false
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            
            
            let categoryCellColor = UIColor(hue: CGFloat(indexPath.row) / 20, saturation: 0.4, brightness: 1, alpha: 1)
            let categoryCellTextColor = UIColor(hue: CGFloat(indexPath.row) / 20, saturation: 0.8, brightness: 0.5, alpha: 1)
            
            
            cell.delegate = self
            cell.backgroundCard.backgroundColor = categoryCellColor
            cell.backgroundCard.hero.id = String(indexPath.row)
            
            cell.categoryName.textColor = categoryCellTextColor
            cell.categoryName.text = categories?[indexPath.row].title ?? ""
            cell.categoryName.isHidden = false
            
            return cell
        }
    }
}


//MARK: SwipeTableViewCellDelegate
extension CategoryViewController: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in

            
            let transition = ScaleTransition(duration: 1, initialScale: 0)
            action.transitionDelegate = transition

            if let category = self.categories?[indexPath.row] {
                self.deleteData(category)
            }
        }

        deleteAction.textColor = .red
        deleteAction.title = nil
        deleteAction.backgroundColor = .white
        deleteAction.image = UIImage(named: "backButton")


        return [deleteAction]
    }
    

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructiveAfterFill
        options.backgroundColor = .white

        return options
    }
}
