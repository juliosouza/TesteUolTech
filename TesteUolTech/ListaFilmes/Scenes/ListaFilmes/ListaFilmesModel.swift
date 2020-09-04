//
//  ListaFilmesModel.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 25/08/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import Foundation

enum ListaFilmesEnum {
    
    struct Response: Codable {
        let id: String
        let items: [items]
        let item_count: Int
    }
    
    
    // MARK: Use cases
        
    struct items: Codable {
        let poster_path: String
        let popularity: Double
        let vote_count: Int
        let video: Bool
        let media_type: String
        let id: Int
        let adult: Bool
        let backdrop_path: String
        let original_language: String
        let original_title: String
        let title: String
        let release_date: String
        let overview: String
    }
        
        
        
        struct Request {
            let service: ListaFilmesAPI
        }
        
        enum ListaFilmesAPI {
            case get
        }
    }

    extension ListaFilmesEnum.ListaFilmesAPI: Endpoint {
        var base: String {
            return Constants.baseURL
        }
        
        var path: String {
            switch self {
            case .get: return Constants.list
            }
        }
    
    
}
