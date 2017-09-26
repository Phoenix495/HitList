//
//  ViewController.swift
//  HitList
//
//  Created by Phoenix on 06.07.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\"The List\""
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do
        {
            let fetchedResult = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResult {
                people = results as! [Person]
            } else {
                
                print("Could not fetch")
            }
        }
        catch
        {
            print(error)
        }
        
    }

    // UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = people[indexPath.row]

        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action: UIAlertAction!) in
            let textField = alert.textFields![0] 
            self.saveName(name: textField.text!)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) in
            
        }
        
        alert.addTextField { (textField: UITextField!) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true) { 
            
        }
        
    }

    func saveName(name: String) {
        
        // До того как вы сможете что-либо сохранить или получить из вашей Core Data, вам все еще нужно поработать с NSManagedObjectContext. Считайте, что управляемый контекст объекта - это "блокнот" для работы с управляемыми объектами.
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context)
        person.setValue(name, forKey: "name")
        
        do
        {
            try context.save()
        }
        catch
        {
            let nserror = error as NSError
            print("Could not save \(nserror), \(nserror.userInfo)")
        }
        
        people.append(person as! Person)
    }
    
    // Hello HitList
}

