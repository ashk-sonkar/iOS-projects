//
//  ViewController.swift
//  ToDoList
//
//  Created by Ashish Kumar Sonkar on 05/07/17.
//  Copyright © 2017 Ashish Kumar Sonkar. All rights reserved.
//

import UIKit
import CoreData
//import Floaty
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, element {
    
    var tasks : [Task] = []
    var count = 0
    var tasks2 : [Task] = []
    
    @IBOutlet weak var segmentOut: UISegmentedControl!
    @IBOutlet weak var newTask: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTable.dataSource = self
        taskTable.delegate = self
        
        do{
            tasks = try  AppDelegate.shared().persistentContainer.viewContext.fetch(Task.fetchRequest()) as! [Task]
        }
        catch{
            print("Error")
        }
        
//        let floaty = Floaty()
//        floaty.addItem(item: UITextField)
//        floaty.addSubview(ViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "task_cell") as! listTableViewCell
        cell.taskTitle.text = tasks[indexPath.row].title
        
        cell.index = Int(tasks[indexPath.row].indexNo)
        if tasks[indexPath.row].completed{
            cell.switchStatus.isOn = false
            cell.status.text = "Task Completed"
        }
        else{
            cell.switchStatus.isOn = true
            cell.status.text = "Task Incomplete"
        }
        cell.delegate = self
        return cell
    }
    @IBAction func addTask(_ sender: UIButton) {
        if newTask.text != "" {
            
            warningLabel .text = ""
            let task1 =  Task(context: AppDelegate.shared().persistentContainer.viewContext)
            task1.title = newTask.text
            task1.completed = false
            task1.indexNo = Int16(count)
            count += 1
            AppDelegate.shared().saveContext()
            
            if segmentOut.selectedSegmentIndex == 0{
                fetchData(flag: "All")
            }
            else{
                if segmentOut.selectedSegmentIndex == 1{
                    fetchData(flag: "True")
                }
                else{
                    fetchData(flag: "False")
                }
            }
            taskTable.reloadData()
            newTask.text = ""
        }
        else{
            warningLabel.text = "Enter Task"
        }
        
    }
    @IBAction func clearAll(_ sender: Any) {
        if tasks != nil {
            
            for task in tasks{
                AppDelegate.shared().persistentContainer.viewContext.delete(task)
            }
            AppDelegate.shared().saveContext()
        }
        fetchData(flag: "All")
        taskTable.reloadData()
        count = 0
    }
    
    func  change(index: Int) {
        
        for task in tasks{
            if Int(task.indexNo) == index{
                
                task.completed = !task.completed
                break
            }
        }
        
        AppDelegate.shared().saveContext()
        if segmentOut.selectedSegmentIndex == 0{
            fetchData(flag: "All")
        }
        else{
            if segmentOut.selectedSegmentIndex == 1{
                fetchData(flag: "True")
            }
            else{
                fetchData(flag: "False")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.taskTable.reloadData()
        })
    }
    
    func deleteTask(index: Int){
        
        
        for task in tasks{
            if Int(task.indexNo) == index{
                
                AppDelegate.shared().persistentContainer.viewContext.delete(task)
                
                break
            }
        }
            AppDelegate.shared().saveContext()
            if segmentOut.selectedSegmentIndex == 0{
                fetchData(flag: "All")
            }
            else{
                if segmentOut.selectedSegmentIndex == 1{
                    fetchData(flag: "True")
                }
                else{
                    fetchData(flag: "False")
                }
            }
            taskTable.reloadData()
        }
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            
            fetchData(flag: "All")
        }
        else{
            if sender.selectedSegmentIndex == 1{
                fetchData(flag: "True")
            }
            else{
                fetchData(flag: "False")
            }
        }
        taskTable.reloadData()
        
    }
    
    func fetchData(flag: String){
        
        
        switch(flag){
        case "All" :
            
            do{
                let request:NSFetchRequest<Task> = Task.fetchRequest()
                
                tasks = try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
            }
            catch{
                print("Error")
            }
        case "True" :
            
            do{
                let request:NSFetchRequest<Task> = Task.fetchRequest()
                
                request.predicate = NSPredicate(format : "completed == %@", NSNumber(value: true))
                tasks = try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
                
            }
            catch{
                
            }
        case "False" :
            
            do{
                let request:NSFetchRequest<Task> = Task.fetchRequest()
                
                request.predicate = NSPredicate(format : "completed == %@", NSNumber(value: false))
                tasks = try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
            }
            catch{
                
            }
            
        default:
            print("Default")
            do{
                let request:NSFetchRequest<Task> = Task.fetchRequest()
                
                tasks = try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
            }
            catch{
                
            }
            
        }
    }
}
