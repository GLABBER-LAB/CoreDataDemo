//
//  AddViewController.swift
//  CoreDataDemo
//
//  Created by GLABBER on 24.10.2022.
//

import UIKit

class AddViewController: UIViewController {
    
    var person: Person?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        if savePerson() {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func savePerson() -> Bool {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не заполнили поле Фамилия - сохранение невозможно", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        // Создаём объект
        if person == nil {
            person = Person()
        }
        
        // Сохранить объект
        if let person = person {
            person.name = nameTextField.text
            person.age = Int16(ageTextField.text!)!
            CoreDataManager.instance.saveContext()
        }
        return true
    }
}