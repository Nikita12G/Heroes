//
//  StartViewController.swift
//  Heroes
//
//  Created by Никита Гуляев on 18.11.2021.
//

import UIKit
import CloudKit

class StartViewController: UITableViewController {
    
    private var heroData = [HeroData]()
    private var searchHero = [HeroData]()
    private var filterData: [String]?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.largeContentTitle = "Take Hero"
        setupSearchBar()
        setupTableView()
        NetworkService().request {data in
            self.heroData = data
            print(data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search hero"
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tabelView: UITableView, numberOfRowsInSection: Int) -> Int {
        if isFiltering {
            return searchHero.count
        }
        return heroData.count
    }
    override func tableView(_ tabelView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        var hero: HeroData
        
        if isFiltering {
            hero = searchHero[indexPath.row]
        } else {
            hero = heroData[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = heroData[indexPath.row].localized_name.capitalized
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "startVCSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroData[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}

extension StartViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func updateSearchResults(for: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        searchHero = heroData.filter({ (hero: HeroData) -> Bool in
            return hero.localized_name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

}


