//
//  ImageLoader.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL?
    private var task: URLSessionDataTask?
    
    init(url: URL?) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard let url = url else {
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}

