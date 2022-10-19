//
//  ImageDownload + UIImageView.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation
import UIKit

extension UIImageView {
    ///  download image cache with url
    ///  - Parameter Image url: imageURL
    func downloadImageWithURL(imageURL: String) {
        self.image = nil
        if let cachedImage = AppConstants.imageCache.object(forKey: NSString(string: imageURL)) {
            self.runOnMainThred { [weak self] in
                self?.image = cachedImage
                Logger.log(.success, "image is fetched from cache \(imageURL)")
                return
            }
        } else {
            let blockOperation = BlockOperation()
            blockOperation.addExecutionBlock ({ [weak self] in
                guard let url = URL(string: imageURL) else {
                    self?.runOnMainThred {
                        self?.image = AppConstants.placeHolderImage
                        Logger.log(.error, "Image URL is wrong")
                    }
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    let newImage = UIImage(data: data)
                    if let newImage = newImage {
                        AppConstants.imageCache.setObject(newImage, forKey: NSString(string: imageURL))
                        self?.runOnMainThred(block: {
                            self?.image = newImage
                        })
                    } else {
                        self?.runOnMainThred {
                            self?.image = AppConstants.placeHolderImage
                            Logger.log(.error, "Image could not be shown")
                        }
                    }
                }
                catch {
                    self?.runOnMainThred {
                        self?.image = AppConstants.placeHolderImage
                        Logger.log(.error, "Image could not be shown")
                    }
                }
            })
            AppConstants.imageQueue.addOperation(blockOperation)
            blockOperation.completionBlock = {
                Logger.log(.success, "Image Downloaded \(imageURL)")
            }
        }
    }
    /// Run function on Main Thred
    ///  - Parameter block: block
    fileprivate func runOnMainThred(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            let mainQueue = OperationQueue.main
            mainQueue.addOperation({
                block()
            })
        }
    }
}
