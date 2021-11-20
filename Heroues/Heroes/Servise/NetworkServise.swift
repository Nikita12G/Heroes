//
//  NetworkServise.swift
//  Heroуs
//
//  Created by Никита Гуляев on 18.11.2021.
//

import Foundation

var hero: [Heroes] = []

class NetworkService {

    func request(completion: @escaping () -> ()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "error data")
                return
            }
            if error == nil {
                do {
                    hero = try JSONDecoder().decode([Heroes].self, from: data)
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


