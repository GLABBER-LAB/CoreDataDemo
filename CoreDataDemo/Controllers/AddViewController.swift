//
//  AddViewController.swift
//  CoreDataDemo
//
//  Created by GLABBER on 24.10.2022.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    struct Constants {
        static let entity = "Departament"
        static let sortNameDep = "nameDep"
    }
    
    var fetchResultController = CoreDataManager.instance.fetchResultController(entityName: Constants.entity, sortName: Constants.sortNameDep)
    
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
    @IBOutlet weak var departamentTextField: UITextField! {
        didSet {
            departamentTextField.inputView = UIView(frame: .zero)
            departamentTextField.addTarget(self, action: #selector(editingDep), for: .editingDidBegin)
        }
    }
    
    @objc func editingDep() {
        let alert = UIAlertController(title: "Выберите отдел", message: nil, preferredStyle: .actionSheet)
        let numberDepartament = fetchResultController.sections![0].numberOfObjects
        
        if numberDepartament != 0 {
            for item in 0...numberDepartament - 1 {
                let departement = fetchResultController.object(at: [0, item]) as! Departament
                alert.addAction((UIAlertAction(title: departement.nameDep, style: .default, handler: { [unowned self] _ in
                    self.textDep = departement.nameDep!
                    departamentTextField.resignFirstResponder()
                })))
            }
        } else {
            alert.addAction(UIAlertAction(title: "?", style: .default, handler: { [unowned self] _ in
                self.textDep = ""
                departamentTextField.resignFirstResponder()
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Возврат", style: .cancel, handler: { [unowned self] _ in
            departamentTextField.resignFirstResponder()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    var textDep: String? {
        didSet {
            departamentTextField.text = textDep
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Чтение объекта
        if let person = person {
            nameTextField.text = person.name
            ageTextField.text = String(person.age)
            departamentTextField.text = person.departament
        }
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func savePerson() -> Bool {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не заполнили все поля - сохранение невозможно", preferredStyle: .alert)
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
            person.departament = departamentTextField.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }
}

