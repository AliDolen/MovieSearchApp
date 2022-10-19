//
//  SplashScreen.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 18.10.2022.
//

import Foundation
import UIKit
import FirebaseRemoteConfig

final class SplashScreen: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: AppConstants.splashLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var remoteConfigText: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        return label
    }()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetworkConnection()
        setupUI()
        applyConstraint()
        fetchValues()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(remoteConfigText)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            remoteConfigText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remoteConfigText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// remote config fetch operation
    private func fetchValues() {
        
        let defaults: [String: NSObject] = [
            "Loodos": "Loodos" as NSObject
        ]
        
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { [weak self] status, error in
            if status == .success && error == nil {
                self?.remoteConfig.activate { _, error in
                    guard error == nil else {
                        Logger.log(.error, "\(error?.localizedDescription ?? "")")
                        return
                    }
                    let value = self?.remoteConfig.configValue(forKey: "Loodos").stringValue
                    self?.updateUI(text: value ?? "")
                }
            } else {
                Logger.log(.error, "Remote Status is false")
            }
        }
    }
    
    private func updateUI(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.remoteConfigText.text = text
        }
    }
}

extension SplashScreen: AlertHelper {
    func checkNetworkConnection() {
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                Router.navigate(to: .movieList)
            }
        } else {
            showNotification(title: "Network Error", message: "Check your internet connection")
        }
    }
}
