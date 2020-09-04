//
//  ListaFilmesPresenter.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 02/09/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import UIKit

protocol ListaFilmesPresentationLogic {
    func presentList(response: ListaFilmesEnum.Response)
    func presentDefaultError()
    
}

class ListaFilmesPresenter: ListaFilmesPresentationLogic
{
    weak var viewController: ListaFilmesDisplayLogic?
    
    
    func presentList(response: ListaFilmesEnum.Response) {
        viewController?.exibirListaFilmes(response: response)
    }
    
    
    func presentDefaultError() {
        viewController?.exibirErroListaFilmes()
    }

}

