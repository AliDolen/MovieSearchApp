//
//  MovieListViewController.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import UIKit

final class MovieSearchViewController: UIViewController {
    
    private lazy var searchBarController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchBarController
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesBackButton = true
        searchBarController.searchResultsUpdater = self
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let querry = searchBar.text,
              !querry.trimmingCharacters(in: .whitespaces).isEmpty,
              querry.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchBarController.searchResultsController as? SearchResultViewController else { return }
        resultController.viewModel.fetchMovieList(query: querry)
    }
}
