//
//  FetchEmployees.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import Foundation
import UIKit
import CoreData

class EmployeeService: NSObject {
    
    public func create(_ employee: EmployeeModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let employeeEntity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)
        
        let insert = NSManagedObject(
            entity: employeeEntity!,
            insertInto: managedContext
        )
        
        insert.setValue(employee.id, forKey: "id")
        insert.setValue(employee.employee_name, forKey: "employee_name")
        insert.setValue(employee.employee_age, forKey: "employee_age")
        insert.setValue(employee.employee_salary, forKey: "employee_salary")
        insert.setValue(employee.profile_image, forKey: "profile_image")
        
        do {
            try managedContext.save()
        } catch let err {
            print(err)
        }
    }

    public func read() -> [EmployeeModel] {
        var employees = [EmployeeModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        print(fetchRequest)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ employee in
                if let id = employee.value(forKey: "id") as? UUID {
                    employees.append(
                        EmployeeModel(
                            id: employee.value(forKey: "id") as! UUID,
                            employee_name: employee.value(forKey: "employee_name") as! String,
                            employee_salary: employee.value(forKey: "employee_salary") as! Int,
                            employee_age: employee.value(forKey: "employee_age") as! Int,
                            profile_image: employee.value(forKey: "profile_image") as! String
                        )
                    )
                } else {
                    let newID = UUID()
                    employees.append(
                        EmployeeModel(
                            id: newID ,
                            employee_name: employee.value(forKey: "employee_name") as! String,
                            employee_salary: employee.value(forKey: "employee_salary") as! Int,
                            employee_age: employee.value(forKey: "employee_age") as! Int,
                            profile_image: employee.value(forKey: "profile_image") as! String
                        )
                    )
                }
                
            }
            print(result)
        } catch let err {
            print(err)
        }
        
        return employees
    }

}


