//
//  ImageView.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 03/09/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func download(from url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async() { [weak self] in
                        self?.image = UIImage(named: "404")
                    }
                    print("nao conseguiu pegar imagem")
                    return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }
}

