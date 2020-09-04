//
//  ListaFilmesInteractor.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 25/08/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import UIKit

protocol InterfaceListaFilmesInteractor {
    func carregaListaFilmes()
}

class ListaFilmesInteractor: InterfaceListaFilmesInteractor {
    
    var worker: ListaFilmesWorker?
    var presenter: ListaFilmesPresentationLogic?
    
    
    func carregaListaFilmes() {
        
        worker = ListaFilmesWorker()
        let request = ListaFilmesEnum.Request(service: .get)
        
        
        worker?.getListaFilmes(request: request, completion: { (result) in
            switch result {
            case .success(let response):
                guard let resp = response else {
                    self.presenter?.presentDefaultError()
                    return }
                self.presenter?.presentList(response: resp)
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.presentDefaultError()
            }
        })
        
        
    }
    
    
    
    
}
