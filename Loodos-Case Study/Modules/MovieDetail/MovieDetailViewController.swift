//
//  MovieDetailViewController.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import UIKit

protocol MovieDetailViewControllerInterface: AnyObject {
    func updateUI(with movieObject: MovieModel)
}

final class MovieDetailViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var viewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraint()
        setupNavigationBar()
        viewModel?.prepareUI()
        viewModel?.logShowEvent()
    }
    
    /// navigation bar setup
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    /// setup user interface
    private func setupUI() {
        view.addSubview(posterView)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 300),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func updateUI(with movieObject: MovieModel) {
        DispatchQueue.main.async { [weak self] in
            guard let imageURL = movieObject.poster_path else { return }
            let url = "\(AppConstants.imageBaseURL)\(imageURL)"
            self?.titleLabel.text = movieObject.overview
            self?.posterView.downloadImageWithURL(imageURL: url)
        }
    }
}

extension MovieDetailViewController {
    /// creates new MovieDetailViewController
    static func build(with movieObject: MovieModel) -> MovieDetailViewController{
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.viewModel = MovieDetailViewModel(interface: movieDetailVC, movieObject: movieObject)
        return movieDetailVC
    }
}
