//
//  SearchResultViewController.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import UIKit

protocol MovieListViewInterface: AnyObject, AlertHelper {
    func movieListFetched()
}

final class SearchResultViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var viewModel: MovieSearchResultViewModelProtocol = MovieSearchResultViewModel(view: self,
                                                                                        networkService: NetworkService(networkRequest: NativeRequestable(),
                                                                                                                                   environment: .development))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showSpinner(onView: self.view)
    }
    
    /// view setup
    private func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension SearchResultViewController: MovieListViewInterface {
    func movieListFetched() {
        self.hideSpinner()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.movieSelected(row: indexPath.row)
    }
}

// MARK: - UICollectionDataView part
extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell {
            let movieObject = viewModel.getMovieObject(row: indexPath.row)
            cell.viewModel = MovieCollectionViewCellViewModel(view: cell, movieObject: movieObject)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovieList()
    }
}

// MARK: - FlowLayout part
extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        MovieListConstants.sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        MovieListConstants.minLineSpacing
    }
}

extension SearchResultViewController {
    private struct MovieListConstants {
        static let minLineSpacing: CGFloat = 0
        static let sizeForItem: CGSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
    }
}
