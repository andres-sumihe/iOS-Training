//
//  DTableViewController.swift
//  training
//
//  Created by P090MMCTSE010 on 18/10/23.
//

import UIKit


class DTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    
    
    var employees: [EmployeeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableCell")

        view.addSubview(tableView)
        
        fetchEmployees { result in
            switch result {
                
            case .success(let employees):
                self.employees = employees
                self.tableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath) as! ProfileTableViewCell

        let employee = employees[indexPath.row]
        cell.titleComponent.text = employee.employee_name
        cell.descriptionComponent.text = "Salary: \(employee.employee_salary)"
        cell.ageComponent.text = "\(employee.employee_age) Tahun"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0 // Set your desired cell height here
    }
    
    @IBOutlet weak var CustomTable:  ProfileTableViewCell!
    @IBOutlet weak var TableComponent: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
