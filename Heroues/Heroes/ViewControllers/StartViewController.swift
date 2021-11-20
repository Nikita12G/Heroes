//
//  StartViewController.swift
//  Heroes
//
//  Created by Никита Гуляев on 18.11.2021.
//

import UIKit

class StartViewController: UITableViewController {
    
    var heroData = [HeroData]()
//    let networkDataFetcher = NetworkDataFetcher()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tabelView: UITableView, numberOfRowsInSection: Int) -> Int {
        return heroData.count
    }
    override func tableView(_ tabelView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = heroData[indexPath.row].localized_name.capitalized
        return cell
        
    }
}
extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}



