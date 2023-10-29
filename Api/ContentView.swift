//
//  ContentView.swift
//  Api
//
//  Created by 이민호 on 2023/10/29.
//

import SwiftUI

let key = "KGDE%2BXVkA7KcalDjlMVg7E%2FRiEBVuIZISFHxHrt02ui3GfttGwAiLUnlXBfd38jKZfXnyZ%2FiA1hp3ThlmASdWw%3D%3D"
let apiURLString = "https://api.odcloud.kr/api/15077586/v1/centers?serviceKey=\(key)"

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Get API") {
                decodeAPI(url:apiURLString)
            }
        }
        .padding()
    }
}

func decodeAPI(url: String) {
    guard let url = URL(string: url) else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let centers = try decoder.decode(CenterResponse.self, from: data)
                centers.data.forEach { center in
                    print(center)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        } else {
            print("Data is nil")
        }
    }
    
    task.resume()
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
