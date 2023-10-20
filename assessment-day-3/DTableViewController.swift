//
//  DTableViewController.swift
//  training
//
//  Created by P090MMCTSE010 on 18/10/23.
//

import UIKit


class DTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var titleLabel: UILabel!
    var stackView: UIStackView!
    
    
    var employees: [EmployeeModelAPI] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds)
        titleLabel = UILabel(frame: view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableCell")
        
        titleLabel.text = "Assessment Day 3"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(frame: view.bounds)
        stackView.axis = .vertical
        stackView.spacing = 8 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tableView)

        view.addSubview(stackView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        
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
