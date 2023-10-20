//
//  EmployeeModel.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import Foundation

struct EmployeeModel: Codable {
    let id: UUID
    var employee_name: String
    var employee_salary: Int
    var employee_age: Int
    var profile_image: String
}

struct EmployeeModelAPI: Codable {
    let id: Int
    var employee_name: String
    var employee_salary: Int
    var employee_age: Int
    var profile_image: String
}

struct EmployeeResponse: Codable {
    let status: String
    let data: [EmployeeModelAPI]?
    let message: String
}
