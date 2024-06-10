//
//  UIImageViewLoadImage.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 13/05/2024.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("errors image fetch")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
