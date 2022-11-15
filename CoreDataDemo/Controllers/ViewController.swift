//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by GLABBER on 22.10.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание объекта
        let managedObject = Person()
        
        // Установка значений атрибутов
        managedObject.name = "Петя"
        managedObject.age = 28
        
        // Извлекаем значение атрибута
        let name = managedObject.name
        let age = managedObject.age
        
        print("\(String(describing: name)), \(age)")
        
        // Сохранение данных
        CoreDataManager.instance.saveContext()
        
        // Извлекаем данные и базы данных
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age)")
            }
        } catch {
            print(error)
        }
        
        // Удаление ВСЕХ записей
//        do {
//            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
//            for result in results as! [NSManagedObject]{
//                CoreDataManager.instance.context.delete(result)
//            }
//        } catch {
//            print(error)
//        }
//
//        // Сохраняем
//        CoreDataManager.instance.saveContext()
    }
}
