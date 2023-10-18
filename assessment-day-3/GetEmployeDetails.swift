import Alamofire

func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
    let apiURL = "https://dummy.restapiexample.com/api/v1/employees"

    AF.request(apiURL).responseDecodable(of: EmployeeResponse.self) { response in
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

struct EmployeeResponse: Codable {
    let status: String
    let data: [Employee]?
    let message: String
}

struct Employee: Codable {
    let id: Int
    let employee_name: String
    let employee_salary: Int
    let employee_age: Int
    let profile_image: String
}
