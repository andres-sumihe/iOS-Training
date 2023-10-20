//
//  APIService.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import Foundation
import Alamofire

class APIService {
    
    let baseUrl = UserDefaults.standard.value(forKey: "base_url") ?? ""
    
    func fetchEmployees(completion: @escaping (Result<[EmployeeModelAPI], Error>) -> Void) {
        let apiURL = "/employees"

        AF.request("\(baseUrl)\(apiURL)").responseDecodable(of: EmployeeResponse.self) { response in
            switch response.result {
            case .success(let response):
                if let employees = response.data {
                    completion(.success(employees))
                } else {
                    completion(.failure(NSError(domain: "DataError", code: 1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
