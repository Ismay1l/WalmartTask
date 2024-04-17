//
//  CountryViewController.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/16/24.
//

import UIKit

class CountryViewController: UIViewController {
    
    private let viewmodel = SearchViewModel()
    private var filteredCountries: [Country] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search name or capital..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.textColor = .black
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchController
    }()
    
    
    private lazy var countriesTableView: UITableView  = {
        let view = UITableView()
        
        view.dataSource = self
        view.delegate = self
        
        view.register(CountriesTableViewCell.self, forCellReuseIdentifier: Constants.countryTableViewCellID.identifier)
        
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpSearchView()
        setUpView()
        fetchData()
    }
    
    private func fetchData() {
        viewmodel.fetchData { [weak self] countries in
            self?.filteredCountries = countries
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
      }
    
    private func setUpView() {
        view.addSubview(countriesTableView)
        
        NSLayoutConstraint.activate([
            
            countriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            countriesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            countriesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 15),
        ])
    }
    
    private func setUpSearchView() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(string: "Search name or capital...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        navigationItem.searchController = searchController
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryTableViewCellID.identifier) as! CountriesTableViewCell
        let item = filteredCountries[indexPath.row]
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.setUp(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = searchText.isEmpty ? viewmodel.countries : viewmodel.countries.filter { country in
            return country.name.localizedCaseInsensitiveContains(searchText) || country.capital.localizedCaseInsensitiveContains(searchText)
        }
        countriesTableView.reloadData()
    }
}




