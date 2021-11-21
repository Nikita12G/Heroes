//
//  NetworkServise.swift
//  Heroes
//
//  Created by Никита Гуляев on 18.11.2021.
//

import UIKit

class NetworkService {
    
    func request(completion: @escaping ([HeroData]) -> ()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "error data")
                return
            }
            
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    let hero = try decoder.decode([HeroData].self, from: data)
                    completion(hero)
                } catch {
                    print(String(describing: error))
                }
            }
        }.resume()
    }
}

