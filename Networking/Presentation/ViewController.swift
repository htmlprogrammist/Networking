//
//  ViewController.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    public var networkManager: NetworkManagerProtocol!
    
    // MARK: - Views
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.zPosition = 1
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        getStocks(for: "AAPL")
//        getStocksForMostActiveCompanies()
        getRecipes()
    }
    
    // MARK: - Private methods
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "Networking"
        view.addSubview(activityIndicator)
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func getStocksForMostActiveCompanies() {
        let endpoint = Endpoint.mostactive()
        let request = NetworkRequest(endpoint: endpoint)
        
        activityIndicator.startAnimating()
        networkManager.perform(request: request) { [unowned self] (result: Result<[Quote], NetworkManagerError>) in
            switch result {
            case .success(let answers):
//                print(answers)
                /// URLSession under the hood does not work on the main thread, so after completing everything, you need to return to it
                DispatchQueue.main.async { [unowned self] in
                    activityIndicator.stopAnimating()
                    textView.text = "\(answers)"
                }
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    
    private func getStocks(for company: String) {
        let endpoint = Endpoint.stock(for: company)
        let request = NetworkRequest(endpoint: endpoint)
        
        activityIndicator.startAnimating()
        networkManager.perform(request: request) { [unowned self] (result: Result<Quote, NetworkManagerError>) in
            switch result {
            case .success(let answer):
                print(answer)
                /// URLSession under the hood does not work on the main thread, so after completing everything, you need to return to it
                DispatchQueue.main.async { [unowned self] in
                    activityIndicator.stopAnimating()
//                    textView.text = "\(answers)"
                }
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    
    private func getRecipes() {
        let endpoint = Endpoint(path: "")
        let request = NetworkRequest(endpoint: endpoint)
        
        activityIndicator.startAnimating()
        networkManager.perform(request: request) { [unowned self] (result: Result<Meals, NetworkManagerError>) in
            switch result {
            case .success(let recipe):
//                print(recipe)
                /// URLSession under the hood does not work on the main thread, so after completing everything, you need to return to it
                DispatchQueue.main.async { [unowned self] in
                    activityIndicator.stopAnimating()
                    textView.text = "\(recipe.meals[0]["strIngredient7"]! ?? "")"
                }
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    
    /// Example of handling error
    /// - Parameter error: error provided from the result of completion in `perform` method of NetworkManager
    private func handleError(error: NetworkManagerError) {
        DispatchQueue.main.async { [unowned self] in
            switch error {
            case .networkError(let error as NSError):
                alertForError(title: "Unexpected error occured", message: "\(error.localizedDescription)")
            case .parsingJSONError:
                alertForError(title: "Server error occured", message: "An incorrect response was received from the server. Please, restart the application or try again later")
            default:
                alertForError(title: "An unexpected error has occurred", message: "Please, restart application or wait for about 10-15 minutes")
            }
        }
    }
}

extension UIViewController {
    
    func alertForError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
