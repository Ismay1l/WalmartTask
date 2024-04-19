//
//  SearchViewModel.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/16/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    var countries: [Country] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let countryService: Dependencies
    
    init(countryService: Dependencies) {
        self.countryService = countryService
    }
    
    func fetchCountryList(callback: @escaping ([Country]) -> Void, errorMessage: @escaping (String) -> Void) {
        guard let url = URL(string: URLS.countries.urlString) else { return }
        
        let countriesPublisher: AnyPublisher<[Country], Error> = countryService.service.request(url, method: .get, parameters: nil) { message in
            errorMessage(message)
        }
        countriesPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.countries = model
                callback(model)
            }
            .store(in: &cancellables)
    }
}



extension SearchViewModel {
    
    private enum URLS {
        case countries
        
        var urlString: String {
            switch self {
            case .countries:
                return "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
            }
        }
    }
}
