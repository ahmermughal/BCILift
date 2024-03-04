//
//  NetworkManager.swift
//  BCILift
//
//  Created by Ahmer Mughal on 26.02.24.
//

import UIKit

class NetworkManager{
    
    static let shared = NetworkManager()
    private let baseURL = "http://elevator.local:8080"

    
    private init(){}
    
    func callLift(completed: @escaping (Result<String, NetworkError>) -> Void ){
        
        let endpoint = baseURL + "/call?destination=-2"
        //let endpoint = baseURL + "/moving"
        print(endpoint)
        guard let url = URL(string: endpoint) else{
            print("Error with URL")
            completed(.failure(.unableToComplete))
            return
        }
        
//        let json: [String : Any] = ["destination" : email,
//                                    "password": password]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Access-Control-Allow-Origin", forHTTPHeaderField: "http://elevator.local:8080")

        
        request.httpMethod = "POST"
        //request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(error ?? "Some Error")
            print(response ?? "Some Response")
            if let _ = error {
                
                completed(.failure(.unableToComplete))
                return
            }
            
            print("StatusCode: \((response as? HTTPURLResponse)?.statusCode)")
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            
            do{
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(String.self, from: data)
                
                
                completed(.success(response))
                
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func goToFloor(floorNumber: Int, completed: @escaping (Result<String, NetworkError>) -> Void ){
        
        let endpoint = baseURL + "/ride?departure=-2&destination=\(floorNumber)"
        
        print(endpoint)
        guard let url = URL(string: endpoint) else{
            print("Error with URL")
            completed(.failure(.unableToComplete))
            return
        }
        
//        let json: [String : Any] = ["email_address" : email,
//                                    "password": password]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(error ?? "Some Error")
            print(response ?? "Some Response")
            if let _ = error {
                
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            
            do{
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(String.self, from: data)
                
                
                completed(.success(response))
                
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
//    func registerUser(regUser: RegisterUser, completed: @escaping (Result<UserCreatedResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/create_account.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(regUser)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let userCreatedResponse = try decoder.decode(UserCreatedResponse.self, from: data)
//                
//                guard userCreatedResponse.error != "The Discount Code is InValid." else {
//                    completed(.failure(.invalidDiscountCode))
//                    return
//                }
//                
//                guard userCreatedResponse.error != "Phone already existEmail already exist" else {
//                    completed(.failure(.accountAlreadyExist))
//                    return
//                }
//                
//                guard userCreatedResponse.error != "Email already exist" else {
//                    completed(.failure(.accountAlreadyExist))
//                    return
//                }
//                
//                guard userCreatedResponse.error != "Phone already exist" else {
//                    completed(.failure(.accountAlreadyExist))
//                    return
//                }
//                
//                completed(.success(userCreatedResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func activateUser(userId: String, code: String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=activate-account&code=\(code)&customers_id=\(userId)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard response.status! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func resendCode(phone: String, userId: String, email:String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/send_sms_4537.php/?phone=\(phone)&customers_id=\(userId)&email_address=\(email)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(DefaultResponse.self, from: data)
//                
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
//        
//        guard let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
//            completed(nil)
//            return
//        }
//        
//        guard let url = URL(string: urlStr) else{
//            completed(nil)
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error == nil,
//                  let response = response as? HTTPURLResponse, response.statusCode == 200,
//                  let data = data,
//                  let image = UIImage(data: data)
//            else{
//                completed(nil)
//                return
//            }
//            completed(image)
//            
//        }
//        task.resume()
//    }
//    
//    func getBanners(completed: @escaping (Result<SliderResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=main-slider"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(SliderResponse.self, from: data)
//                
//                guard response.isSuccess! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                print("Failed To Decode")
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getParentCategories(completed: @escaping (Result<CategoriesResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=parent-category-list"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(CategoriesResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getChildCategories(of parentId: String,completed: @escaping (Result<CategoriesResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=child-category-list&category_id=\(parentId)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(CategoriesResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getProducts(of categoryId: String,completed: @escaping (Result<ProductListResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=product-by-category&categories_id=\(categoryId)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductListResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getProductDetails(of productId: String,completed: @escaping (Result<ProductDetailsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=product-one&products_id=\(productId)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductDetailsResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func postProductRating(of productId: String, rating: Int,completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/add_products_review.php?req=add-review"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json: [String : Any] = ["customers_id" : Helper.getUserId(),
//                                    "products_id": productId, "reviews_rating": rating]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            print(data)
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard response.isSuccess! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getFilters(of categoryId: String, completed: @escaping (Result<ProductFilterResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=filter-by-category&categories_id=\(categoryId)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductFilterResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getProducts(of categoryId: String, filters: [String:String], completed: @escaping (Result<ProductListResponse, CenError>) -> Void ){
//        
//        var endpoint = getURL() + "web-api/?req=product-by-category&categories_id=\(categoryId)&"
//        
//        filters.forEach{
//            endpoint.append("\($0.key)=\($0.value)&")
//        }
//        endpoint = String(endpoint.dropLast())
//        
//        print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductListResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getProductsBySearch(searchString: String,completed: @escaping (Result<SearchResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=product-search&keywords=\(searchString)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(SearchResponse.self, from: data)
//                
//                guard response.status else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getUserDetails(completed: @escaping (Result<UserDetailsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=get-customer-detail&key=centau47391&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(UserDetailsResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func updateUser(updateUserDetails: UpdateUserDetails, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/account_edit.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(updateUserDetails)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let userCreatedResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard userCreatedResponse.status! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(userCreatedResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getCities(completed: @escaping (Result<CityResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-cities"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(CityResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func getAreas(of id: String, completed: @escaping (Result<AreaResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-areas&city_id=\(id)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(AreaResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func updateAddress(updateAddress: UpdateAddress, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/address_book_process.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(updateAddress)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let addressUpdateResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard addressUpdateResponse.status! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(addressUpdateResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func updatePassword(currentPassword: String, newPassword: String, confirmPassword: String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/account_password.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json: [String : Any] = ["customers_id" : Helper.getUserId(),
//                                    "password_current": currentPassword,
//                                    "password_new" : newPassword,
//                                    "password_confirmation" : confirmPassword]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = jsonData
//        
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let updatePasswordResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard updatePasswordResponse.status! else {
//                    completed(.failure(.passswordUpdateFailed))
//                    return
//                }
//                
//                completed(.success(updatePasswordResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func uploadCartToServer(addToCart: AddToCart, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/cart_update.php?req=add-product-to-cart"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(addToCart)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let addressUpdateResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard addressUpdateResponse.isSuccess! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(addressUpdateResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getCartProducts(completed: @escaping (Result<GetCartItemsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=get-cart-items&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(GetCartItemsResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func emptyServerCart(){
//        
//        let endpoint = getURL() + "web-api/?req=empty-cart&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                return
//            }
//            
//            
//            guard let _ = data else{
//                return
//            }
//        }
//        task.resume()
//    }
//    
//    func getUserPoints(completed: @escaping (Result<PointsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=customer-points&key=centau47391&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(PointsResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func getPromoDetails(completed: @escaping (Result<PromoDetailsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=verify-discount-code-new-versions&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(PromoDetailsResponse.self, from: data)
//                
//                guard currnetResponse.status else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func checkout(_ checkoutProduct: CheckoutProduct, completed: @escaping (Result<CheckoutResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/checkout_process.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(checkoutProduct)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            
//
//            do{
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(CheckoutResponse.self, from: data)
//                
//                guard currentResponse.status else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getNews(completed: @escaping (Result<NewsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-news"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(NewsResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getOrders(completed: @escaping (Result<OrdersResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=get-order-by-customer&key=centau47395&customers_id=\(Helper.getUserId())"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(OrdersResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func updateFCM(fcmToken: String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/update_fcm_token.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json: [String : Any] = ["customers_id" : Helper.getUserId(),                                       "fcm_token": fcmToken]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = jsonData
//        
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard currentResponse.isSuccess! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func checkCanPayByCard(completed: @escaping (Result<PaymentOptionAndDiscountResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=customer-order-count&customers_id=\(Helper.getUserId())"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(PaymentOptionAndDiscountResponse.self, from: data)
//                
//                //                guard currnetResponse.isSuccess else {
//                //                    completed(.failure(.invalidResponse))
//                //                    return
//                //                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func sendForgotPassWordOTP(emailAddress: String?, phone: String?, completed: @escaping (Result<ForgotPasswordOTPResponse, CenError>) -> Void ){
//        var endpoint :String = getURL()
//        
//        if let safeEmail = emailAddress {
//            endpoint = getURL() + "web-api/verify_forgot_password.php?email_address=\(safeEmail)"
//        }else if let safePhone = phone {
//            endpoint = getURL() + "web-api/verify_forgot_password.php?phone=\(safePhone)"
//        }
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(ForgotPasswordOTPResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.incorrectEmailOrPhone))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func resetPassword(customerId: String, otp: String, password: String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/reset_password.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json: [String : Any] = ["customers_id" : customerId,
//                                    "otp": otp,
//                                    "password_new": password,
//                                    "password_confirmation" : password]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = jsonData
//        
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard currentResponse.status! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getMinOrderAmount(completed: @escaping (Result<MinOrderAmountResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=min-order-amount"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(MinOrderAmountResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getProductsStock(checkStockProducts : CheckStockProducts ,completed: @escaping (Result<CheckStockResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/check_stock.php"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(checkStockProducts)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(CheckStockResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func getPopUpDetails(completed: @escaping (Result<PopUpResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-popup"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(PopUpResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func postUserParticipation(userParticipation : UserParticipation ,completed: @escaping (Result<UserParticipationResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/update_event_data.php"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json = try? JSONEncoder().encode(userParticipation)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(UserParticipationResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    //MARK: Test API Need to remove
//    
//    //    func getTestPromoDetails(completed: @escaping (Result<PromoDetailsResponse, CenError>) -> Void ){
//    //
//    //        let endpoint = getURL() + "web-api/index.php?req=check-discount-promo"
//    //
//    //        guard let url = URL(string: endpoint) else{
//    //            completed(.failure(.unableToComplete))
//    //            return
//    //        }
//    //
//    //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//    //            if let _ = error {
//    //                completed(.failure(.unableToComplete))
//    //                return
//    //            }
//    //
//    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//    //                completed(.failure(.unableToComplete))
//    //                return
//    //            }
//    //
//    //
//    //            guard let data = data else{
//    //                completed(.failure(.invalidData))
//    //                return
//    //            }
//    //
//    //            print(String(data: data, encoding: .utf8))
//    //
//    //            do{
//    //                let decoder = JSONDecoder()
//    //                let currnetResponse = try decoder.decode(PromoDetailsResponse.self, from: data)
//    //
//    //                guard currnetResponse.status else {
//    //                    completed(.failure(.invalidResponse))
//    //                    return
//    //                }
//    //
//    //                completed(.success(currnetResponse))
//    //
//    //            }catch{
//    //                completed(.failure(.invalidData))
//    //            }
//    //        }
//    //        task.resume()
//    //    }
//    
//    func getPromoCodeProducts(under amount: Double, completed: @escaping (Result<ProductListResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-promo-products&price=\(amount)"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductListResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getNewOrBestProducts(newOrBest: NewOrBestProduct, completed: @escaping (Result<ProductListResponse, CenError>) -> Void ){
//        
//        var endpoint = ""
//        
//        switch newOrBest {
//        case .newProducts:
//            endpoint = getURL() + "web-api/index.php?req=new-arrival-products"
//        case .bestProducts:
//            endpoint = getURL() + "web-api/index.php?req=best-product"
//        }
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(ProductListResponse.self, from: data)
//                
//                guard response.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getCurrentBuildVersion(completed: @escaping (Result<CurrentBuildResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=build-version&platform=ios"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(CurrentBuildResponse.self, from: data)
//                
//                
//                completed(.success(response))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func updateOrder(orderID : Int, orderReference: String, paymentType : String, completed: @escaping (Result<DefaultResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/payment_success.php"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let json: [String : Any] = ["order_id" : orderID,
//                                    "order_reference": orderReference,
//                                    "payment_type": paymentType]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = jsonData
//        
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(DefaultResponse.self, from: data)
//                
//                guard currentResponse.isSuccess! else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func createNGOrder(orderNum : Int, amount: Double, emailAddress : String, accessToken : String, completed: @escaping (Result<OrderResponse, CenError>) -> Void ){
//        
//        let endpoint = paymentGatewayURL + "transactions/outlets/" + outletReference + "/orders"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        let fixedPrice = amount * 100
//        let order = NGOrderCreate(action: "SALE", emailAddress: emailAddress, amount: NGOrderCreateAmount(currencyCode: "AED", value: fixedPrice), merchantOrderReference: orderNum)
//        
//        let json = try? JSONEncoder().encode(order)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = ["Authorization": "Bearer " + accessToken,
//                                       "Content-Type" : "application/vnd.ni-payment.v2+json",
//                                       "Accept" : "application/vnd.ni-payment.v2+json"]
//        request.httpBody = json
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                print(error)
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            print(response)
//            
//            guard let response = response as? HTTPURLResponse, (200 ..< 300).contains(response.statusCode) else{
//                print("Status Code Error")
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            // print(String(data: data, encoding: .utf8))
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            print(String(data: data, encoding: .utf8))
//            
//            
//            do{
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(OrderResponse.self, from: data)
//                
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func ngAccessToken(completed: @escaping (Result<AccessTokenResponse, CenError>) -> Void ){
//        
//        let endpoint = paymentGatewayURL + "identity/auth/access-token"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = ["Authorization": "Basic YmNkYWRkMjItMmQ3Ni00MmZiLTgwM2EtM2YyZjljZTc2NTQ2OmYyNGUwNTU4LWU1NzEtNGUyNS05MWFjLWQxNmY2ODg4NGFmZQ==",
//                                       "Content-Type" : "application/vnd.ni-identity.v1+json"]
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                let currentResponse = try decoder.decode(AccessTokenResponse.self, from: data)
//                
//                
//                completed(.success(currentResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getOrderDetails(orderID : String, completed: @escaping (Result<OrderProductsDetailsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/?req=get-order-by-id&key=centau47491&orders_id=\(orderID)"
//        //print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(OrderProductsDetailsResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getCustomerNotificationHistory(customerID : String, completed: @escaping (Result<UserNotificationResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=get-notif-log&customers_id=\(customerID)"
//        print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                print("Data Error")
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(UserNotificationResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func getCustomerReviews(customerID : String, completed: @escaping (Result<UserReviewsResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "web-api/index.php?req=customer-reviews&customers_id=\(customerID)"
//        print(endpoint)
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        print(url)
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(UserReviewsResponse.self, from: data)
//                
//                guard currnetResponse.isSuccess else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//    
//    func getFOCDetails(completed: @escaping (Result<FOCResponse, CenError>) -> Void ){
//        
//        let endpoint = getURL() + "/web-api/index.php?req=verify-discount-code-foc&customers_id=\(Helper.getUserId())"
//        
//        guard let url = URL(string: endpoint) else{
//            completed(.failure(.unableToComplete))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            
//            guard let data = data else{
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            //print(String(data: data, encoding: .utf8))
//            
//            do{
//                let decoder = JSONDecoder()
//                let currnetResponse = try decoder.decode(FOCResponse.self, from: data)
//                
//                guard currnetResponse.status else {
//                    completed(.failure(.invalidResponse))
//                    return
//                }
//                
//                completed(.success(currnetResponse))
//                
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
    
}
