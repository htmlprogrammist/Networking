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
        view.backgroundColor = .systemBackground
        title = "Networking"
    }
    
    func loadPreviews(of news: [NewsViewModel]) async {
        await withTaskGroup(of: Void.self) { group in
            for news in news {
                group.addTask { [weak self] in
                    await self?.loadImage(of: news)
                }
            }
        }
    }
    
    private func loadImage(of news: NewsViewModel) async {
        guard let url = news.underlyingModel.preview else {
            return
        }
        
        if let image = await imageLoader.loadImage(at: url) {
            news.preview = Image(uiImage: image)
        }
    }
}
