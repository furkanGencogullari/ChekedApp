//
//  AddViewController.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 12.02.2023.
//

import UIKit
import Hero
import RealmSwift


class AddCategoryViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var addButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goBackToCategoriesVC))
        blurView.addGestureRecognizer(gesture)
        
        
        let buttonGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        addButton.addGestureRecognizer(buttonGesture)
    }
    
    
    @objc func goBackToCategoriesVC() {
        textField.endEditing(true)
        self.dismiss(animated: true)
    }
    
    
    @objc func buttonPressed() {
        if textField.text == "" {
            shakeView(addButton)
        } else if let categoryName = textField.text {
            
            let newCategory = Category()
            newCategory.title = categoryName
            self.save(category: newCategory)

            goBackToCategoriesVC()
        }
    }
    
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error \n realm.write")
        }
    }
    
    
    func shakeView(_ view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0 ]
        view.layer.add(animation, forKey: "shake")
    }

}

