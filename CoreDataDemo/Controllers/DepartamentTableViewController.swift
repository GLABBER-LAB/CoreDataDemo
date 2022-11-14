//
//  DepartamentTableViewController.swift
//  CoreDataDemo
//
//  Created by GLABBER on 13.11.2022.
//

import UIKit
import CoreData

class DepartamentTableViewController: UITableViewController {
    
    struct Constants {
        static let entity = "Departament"
        static let sortName = "nameDep"
        static let cellName = "CellDep"
        static let identifier = "DepInAdd"
    }
    
    var fetchResultController = CoreDataManager.instance.fetchResultController(entityName: Constants.entity, sortName: Constants.sortName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        
        //  Удаляем разлиновку пустых ячеек
        tableView.tableFooterView = UIView()
        
        // Сделаем заголовки большими
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        let departament = fetchResultController.object(at: indexPath) as! Departament
        
        cell.textLabel?.text = departament.nameDep
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let departament = fetchResultController.object(at: indexPath) as! Departament
        performSegue(withIdentifier: Constants.identifier, sender: departament)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let departament = fetchResultController.object(at: indexPath) as! Departament
            CoreDataManager.instance.context.delete(departament)
            CoreDataManager.instance.saveContext()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.identifier {
            let controller = segue.destination as! AddDepViewController
            controller.departament = sender as? Departament
        }
    }
    
}
extension DepartamentTableViewController: NSFetchedResultsControllerDelegate {
    
    // Информирует о начале изменений данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let departament = fetchResultController.object(at: indexPath) as! Departament
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = departament.nameDep
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        default:
            break
        }
    }
    
    // Информирует о окончании изменения данных
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
