//
//  ViewController.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 25/08/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import UIKit

protocol ListaFilmesDisplayLogic: class {
    func exibirListaFilmes(response: ListaFilmesEnum.Response)
    func exibirErroListaFilmes()
}

class ListaFilmesViewController: UIViewController, ListaFilmesDisplayLogic {

    
    //MARK: Outlets
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    
    //MARK: Variables

    var interactor: InterfaceListaFilmesInteractor?
    var list: [ListaFilmesEnum.items] = []

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaListaFilmes()
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    // MARK: Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let viewController = self
        let interactor = ListaFilmesInteractor()
        let presenter = ListaFilmesPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detalhe" {
            if let destination = segue.destination as? DetalheFilmeViewController {
                if let object = sender as? ListaFilmesEnum.items {
                    destination.detalhe = object
                }
            }
        }
    }
    
    
    // MARK: functions

    func carregaListaFilmes() {
        
        interactor?.carregaListaFilmes()
    }
    
    func exibirErroListaFilmes() {
        print("Alert: Erro da requisição")
    }
    
    func exibirListaFilmes(response: ListaFilmesEnum.Response) {
        list = response.items
        collectionMovies.reloadData()
    }
    
}

extension ListaFilmesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width/2) - 25
        return CGSize(width: width, height: 305)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MovieCollectionViewCell
        
        cell.labelMovie.text = list[indexPath.row].original_title
        cell.imageMovie.layer.cornerRadius = 10
        cell.imageMovie.contentMode = .scaleAspectFill
        cell.imageMovie.download(from: Constants.baseImageURL + list[indexPath.row].poster_path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detalhe", sender: list[indexPath.row])
    }

}
