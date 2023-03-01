//
//  AddItemViewController.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 13.02.2023.
//

import UIKit
import Hero
import RealmSwift

class AddItemViewController: UIViewController {
    
    let realm = try! Realm()
    var selectedCategory: Category?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var addButtonLabel: UILabel!
    @IBOutlet weak var textFieldBackground: UIView!
    var textFieldBackgroundColor = UIColor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldBackground.backgroundColor = textFieldBackgroundColor
        textField.textColor = .white
        
//        addButtonLabel.font = UIFont(name: BrandFont.bold, size: 17)
//        textField.font = UIFont(name: BrandFont.regular, size: 16)
        
//        blurView.hero.modifiers = [.fade]
//        blurView.layer.opacity = 0.9
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goBackToItems))
        blurView.addGestureRecognizer(gesture)
        
        let buttonGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        addButton.addGestureRecognizer(buttonGesture)
    }

    
    @objc func goBackToItems() {
        textField.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @objc func buttonPressed() {
        if textField.text == "" {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.duration = 0.5
            animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0 ]
            addButton.layer.add(animation, forKey: "shake")
        } else if let itemName = textField.text {
            if let currentCategory = selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = itemName
                        currentCategory.items.append(newItem)
                        self.goBackToItems()
                    }
                } catch {
                    print("Error \n Realm Saving")
                }
            }
        }
    }
}
