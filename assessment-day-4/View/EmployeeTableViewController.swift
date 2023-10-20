//
//  EmployeeTableViewController.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import UIKit
import CoreData

class EmployeeTableViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var button: UIButton!
    var stackView: UIStackView!
    var titleLabel: UILabel!
    
    let empService: EmployeeService = EmployeeService()
    
//    var employees: [EmployeeModel] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var viewModel: EmployeeViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds)
        button = UIButton(frame: view.bounds)
        titleLabel = UILabel(frame: view.bounds)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableCell")
        
        
        titleLabel.text = "Assessment Day 4"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(frame: view.bounds)
        stackView.axis = .vertical
        stackView.spacing = 8 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(button)
        
        view.addSubview(stackView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50), // Set the desired height
            button.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        viewModel = EmployeeViewModel()
//        viewModel.fetchData()
        viewModel.loadDataFromLocalDB()
        viewModel.bindDataToVC = {
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath) as! ProfileTableViewCell
        
        let employee = viewModel.employeeData[indexPath.row]
        cell.titleComponent.text = employee.employee_name
        cell.descriptionComponent.text = "Salary: \(employee.employee_salary)"
        cell.ageComponent.text = "\(employee.employee_age) Tahun"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0 // Set your desired cell height here
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employee = viewModel.employeeData[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Employee", message: "Edit employee details", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
            textField.text = employee.employee_name
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Salary"
            textField.text = "\(employee.employee_salary)"
            textField.keyboardType = .numberPad
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Age"
            textField.text = "\(employee.employee_age)"
            textField.keyboardType = .numberPad
        }
        
        let managedContext = self.appDelegate.persistentContainer.viewContext
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { action in
            //            guard let self = self else { return }
            if let nameField = alert.textFields?[0],
               let salaryField = alert.textFields?[1],
               let ageField = alert.textFields?[2],
               let name = nameField.text,
               let salary = Int(salaryField.text!),
               let age = Int(ageField.text!) {
                
                
                let uuidString = self.viewModel.employeeData[indexPath.row].id.uuidString

                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
                fetchRequest.predicate = NSPredicate(format: "id == %@", uuidString)

                
                // Update the employee object with the edited data
                do {
                    let result = try managedContext.fetch(fetchRequest)
                    
                    if let employee = result.first as? NSManagedObject {
                        employee.setValue(name, forKey: "employee_name")
                        employee.setValue(Int(salary), forKey: "employee_salary")
                        employee.setValue(Int(age), forKey: "employee_age")
                        
                        do {
                            try managedContext.save()
                            self.viewModel.loadDataFromLocalDB()
                            self.tableView.reloadData()
                        } catch {
                            print("Error saving data: \(error)")
                        }
                    }
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            // Handle the delete action here
            let managedContext = self.appDelegate.persistentContainer.viewContext
            let uuidString = self.viewModel.employeeData[indexPath.row].id.uuidString

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            fetchRequest.predicate = NSPredicate(format: "id == %@", uuidString)

            do {
                let result = try managedContext.fetch(fetchRequest)
                
                if let objectToDelete = result.first as? NSManagedObject {
                    managedContext.delete(objectToDelete)
                    do {
                        try managedContext.save()
                    } catch {
                        print("Error deleting data: \(error)")
                    }
                } else {
                    print("Data not found")
                }
            } catch let error {
                print("Error fetching data: \(error)")
            }
            self.viewModel.loadDataFromLocalDB()
            self.tableView.reloadData()
            
            // Delete the row from the table view
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func addButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Employee", message: "Enter employee details", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Name"
        }

        alert.addTextField { textField in
            textField.placeholder = "Salary"
            textField.keyboardType = .numberPad
        }

        alert.addTextField { textField in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }

        let addEmployeeAction = UIAlertAction(title: "Add", style: .default, handler: { [weak self] action in
            if let nameField = alert.textFields?[0],
               let salaryField = alert.textFields?[1],
               let ageField = alert.textFields?[2],
               let name = nameField.text,
               let salary = Int(salaryField.text ?? ""),
               let age = Int(ageField.text ?? "") {
                
                // Assuming you have set up your managed context
                let managedContext = self?.appDelegate.persistentContainer.viewContext
                
                // Create a new Employee managed object and set its attributes
                if let employeeEntity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext!),
                   let newEmployee = NSManagedObject(entity: employeeEntity, insertInto: managedContext) as? Employee {
                    newEmployee.id = UUID()
                    newEmployee.employee_name = name
                    newEmployee.employee_salary = Int64(salary)
                    newEmployee.employee_age = Int64(age)
                    newEmployee.profile_image = ""
                    
                    do {
                        // Save the managed object context to persist the changes
                        try managedContext?.save()
                        print("Employee data added successfully!")
                        
                        // Optionally, reload your table view or update your data source
                        self?.viewModel.loadDataFromLocalDB()
                        self?.tableView.reloadData()
                        
                    } catch {
                        print("Error saving data: \(error)")
                    }
                }
            }
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(addEmployeeAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    


    
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
}
