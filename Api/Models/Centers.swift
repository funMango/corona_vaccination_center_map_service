//
//  Centers.swift
//  Api
//
//  Created by 이민호 on 2023/10/29.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case dataIsNil
    case decoding
    case urlSession
}

let serviceKey = "KGDE%2BXVkA7KcalDjlMVg7E%2FRiEBVuIZISFHxHrt02ui3GfttGwAiLUnlXBfd38jKZfXnyZ%2FiA1hp3ThlmASdWw%3D%3D"
let apiURL = "https://api.odcloud.kr/api/15077586/v1/centers?serviceKey=\(serviceKey)"

class Centers {
    var data: CenterResponse?
    
    init(data: CenterResponse? = nil) {
        fetchData()
    }
    func fetchData() {
        load(url: "https://example.com/some-data-endpoint") { (result: CenterResponse?, error) in
            if let error = error {
                // 에러 처리
                print("Error: \(error)")
            } else if let result = result {
                // 성공적으로 디코딩된 데이터를 클래스 프로퍼티에 할당
                self.data = result
                
                // 이제 클래스 내에서 yourData를 사용할 수 있음
                print("Your data: \(String(describing: self.data))")
            }
        }
    }
}




func load<T: Decodable>(url: String, completionHandler: @escaping (T?, CustomError?) -> Void) {
    guard let url = URL(string: url) else {
        print("Invalid URL")
        completionHandler(nil, .invalidURL)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            completionHandler(nil, .urlSession)
            return
        }
        
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completionHandler(decodedData, nil)
            } catch {
                print("Error decoding data: \(error)")
                completionHandler(nil, .decoding)
            }
        } else {
            print("Data is nil")
            completionHandler(nil, .dataIsNil)
        }
    }
    
    task.resume()
}
