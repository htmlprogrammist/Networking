//
//  ViewController.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "Networking"
        
        getStocksForMostActiveCompanies()
        getStocks(for: "AAPL")
    }
    
    private func getStocksForMostActiveCompanies() {
        
    }
    
    private func getStocks(for company: String) {
        
    }
    
    private func handleError(error: NetworkManagerError) {
        DispatchQueue.main.async { [unowned self] in
            switch error {
            case .networkError(let statusCode):
//                alertForError(title: "Unstable internet connection", message: "Please, check your connection and then try again or use a different network")
                alertForError(title: "\(statusCode) error occured", message: "Please, check your connection and then try again or use a different network \(statusCode.rawValue)")
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
