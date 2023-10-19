//
//  EmployeeViewModel.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import Foundation

class EmployeeViewModel: NSObject {
    private var apiService: APIService
    private var employeeService: EmployeeService
    private(set) var employeeData: [EmployeeModel] = [] {
        didSet {
            self.bindDataToVC()
        }
    }
    
    var bindDataToVC: () -> () = {}
    
    override init(){
        self.apiService = APIService()
        self.employeeService = EmployeeService()

        super.init()
    }
    
    func loadDataFromLocalDB() {
        self.employeeData = employeeService.read()
        print(self.employeeData.count)
    }
    
    func fetchData() {
        print(self.employeeData.count)
        apiService.fetchEmployees { result in
            switch result {
                case .success(let employees):
                    self.employeeData = employees
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}
