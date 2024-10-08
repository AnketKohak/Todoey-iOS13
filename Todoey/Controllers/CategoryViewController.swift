//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anket Kohak on 16/08/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectCategory = categories[indexPath.row]
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    func save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error saving category\(error)")
        }
        tableView.reloadData()
    }
    func loadCategories(){
//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//            categories = try context.fetch(request)
//            
//        }catch{
//            print("error for loading category\(error)")
//        }
//        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        var textfield = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { UIAlertAction in
            let newCategory = Category()
            newCategory.name = textfield.text!
            self.categories.append(newCategory)
            self.save(category: newCategory)
            
        }
        alert.addAction(action)
        alert.addTextField { field in
            textfield = field
            textfield.placeholder = "Add a New category"
            
            
        }
        present(alert, animated: true, completion: nil)
    }
    
}
