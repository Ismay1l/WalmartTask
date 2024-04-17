//
//  SearchViewModel.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/16/24.
//

import Foundation

class SearchViewModel {
    
    private(set) var countries = [Country]()
    
    func fetchData(completion: @escaping ([Country]) -> Void) {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                self.countries = try JSONDecoder().decode([Country].self, from: data)
                completion(self.countries)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
}


