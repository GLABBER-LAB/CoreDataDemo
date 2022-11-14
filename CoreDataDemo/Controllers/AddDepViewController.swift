//
//  AddDepViewController.swift
//  CoreDataDemo
//
//  Created by GLABBER on 13.11.2022.
//

import UIKit

class AddDepViewController: UIViewController {
    
    var departament: Departament?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if saveDepartament() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var departamentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Чтение объекта
        if let departament = departament {
            departamentTextField.text = departament.nameDep
        }
    }
    
    func saveDepartament() -> Bool {
        
        if departamentTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не заполнили поле ОТДЕЛ - сохранение невозможно", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        // Создаём объект
        if departament == nil {
            departament = Departament()
        }
        
        // Сохранить объект
        if let departament = departament {
            departament.nameDep = departamentTextField.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }
}
