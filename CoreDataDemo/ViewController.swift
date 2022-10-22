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
        
        // Ссылка на AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Создаем контекст
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        // Создание объекта
        //let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        let managedObject = Person(entity: entityDescription!, insertInto: context)
        
        // Установка значений атрибутов
//        managedObject.setValue("Вася", forKey: "name")
//        managedObject.setValue(18, forKey: "age")
        managedObject.name = "Оля"
        managedObject.age = 34
        
        // Извлекаем значение атрибута
//        let name = managedObject.value(forKey: "name")
//        let age = managedObject.value(forKey: "age")
        let name = managedObject.name
        let age = managedObject.age
        
        print("\(name), \(age)")
        
        // Сохранение данных
        appDelegate.saveContext()
        
        // Извлекаем данные и базы данных
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try context.fetch(fetchRequest)
//            for result in results as! [NSManagedObject]{
//                print("name - \(result.value(forKey: "name")!), age - \(result.value(forKey: "age")!)")
//            }
            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age)")
        }
        } catch {
            print(error)
        }
        
        // Удаление ВСЕХ записей
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                context.delete(result)
            }
        } catch {
            print(error)
        }
        
        // Сохраняем
        appDelegate.saveContext()
    }
}
