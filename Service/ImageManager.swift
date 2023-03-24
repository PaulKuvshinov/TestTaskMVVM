//
//  ImageManager.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import Foundation

protocol ImageManagerProtocol {
    func getImageData(id:String, complition: @escaping(Data) -> Void)
}

final class ImageManager: ImageManagerProtocol {
    
    let urlString = "https://www.roxiemobile.ru/careers/test/images/"
    
    private var imageCache = NSCache<NSString, NSData>()
    
    func getImageData(id: String, complition: @escaping (Data) -> Void) {
        let fullUrlString = urlString + id
        
        guard let url = URL(string: fullUrlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: fullUrlString as NSString) as Data? {
            complition(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let _ = URLSession.shared.dataTask(with: request) {  data, response, error in
                guard error == nil, data != nil else { return }
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    complition(data)
                }
            }.resume()
        }
    }
}
