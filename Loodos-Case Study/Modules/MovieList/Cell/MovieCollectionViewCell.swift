//
//  MovieCollectionViewCell.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation
import UIKit

protocol MovieCollectionViewCellInterface: AnyObject {
    func updateUI(with movieObject: MovieModel)
}

final class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    lazy private var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var viewModel: MovieCollectionViewCellViewModel? {
        didSet {
            viewModel?.prepeareUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(moviePoster)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePoster.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviePoster.frame = contentView.bounds
    }
}

// MARK: - Implemantation of MovieCollectionViewCellInterface
extension MovieCollectionViewCell: MovieCollectionViewCellInterface {
    func updateUI(with movieObject: MovieModel) {
        if let imageURL = movieObject.poster_path {
            let url = "\(AppConstants.imageBaseURL)\(imageURL)"
            DispatchQueue.main.async { [weak self] in
                self?.moviePoster.downloadImageWithURL(imageURL: url)
            }
        }
    }
}
