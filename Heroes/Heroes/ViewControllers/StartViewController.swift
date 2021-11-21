//
//  StartViewController.swift
//  Heroes
//
//  Created by Никита Гуляев on 18.11.2021.
//

import UIKit

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
        searchController.searchResultsUpdater = self
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
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search hero"
        navigationItem.searchController = searchController
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
    
//    MARK: - Table view data sours
    override func tableView(_ tabelView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        var hero: HeroData
        
        if isFiltering {
            hero = searchHero[indexPath.row]
        } else {
            hero = heroData[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = hero.localized_name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "startVCSegue", sender: self)
    }
    
//    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            
            var hero: HeroData
            
            if isFiltering {
                hero = searchHero[tableView.indexPathForSelectedRow?.row ?? 0]
            } else {
                hero = heroData[tableView.indexPathForSelectedRow?.row ?? 0]
            }
            destination.hero = hero
            
        }
    }
}

// MARK: - UISearchResultUpdating
extension StartViewController: UISearchResultsUpdating {
    
    private func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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

