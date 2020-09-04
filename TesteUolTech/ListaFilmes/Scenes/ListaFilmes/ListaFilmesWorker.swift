//
//  ListaFilmesWorker.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 27/08/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import UIKit
    

class ListaFilmesWorker: APIClient {
    
    
    var session: URLSession
     
     init(configuration: URLSessionConfiguration) {
         self.session = URLSession(configuration: configuration)
     }
     
     convenience init() {
         self.init(configuration: .default)
     }
     
     func getListaFilmes(request: ListaFilmesEnum.Request, completion: @escaping (Result<ListaFilmesEnum.Response?, APIError>) -> Void) {
         let endpoint = request.service
         var request = endpoint.request
         
         guard let url = request.url else {return}
         guard let abs = url.absoluteString.removingPercentEncoding else { return }
         
         request.url = URL(string: abs)
         request.httpMethod = "get"
         fetch(with: request, decode: { json -> ListaFilmesEnum.Response? in
             guard let feedResult = json as? ListaFilmesEnum.Response else {
                 return  nil }
             return feedResult
         }, completion: completion) 
     }
    
    
}
