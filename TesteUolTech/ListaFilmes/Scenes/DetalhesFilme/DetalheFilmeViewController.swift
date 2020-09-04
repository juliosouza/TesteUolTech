//
//  DetalheFilmeViewController.swift
//  TesteUolTech
//
//  Created by Julio Cezar de Souza on 03/09/20.
//  Copyright © 2020 Julio Souza. All rights reserved.
//

import UIKit

protocol DetalheDisplayLogic: class {
}

class DetalheFilmeViewController: UIViewController, DetalheDisplayLogic {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var tituloFilme: UILabel!
    @IBOutlet weak var yearMovieDetalhe: UILabel!
    @IBOutlet weak var adultMovieDetalhe: UILabel!
    @IBOutlet weak var overviewMovieDetalhe: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    

    // MARK: Variáveis
    
    var detalhe: ListaFilmesEnum.items?
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor.black
        atualizarTela()
    }
    
    
    // MARK: functions

    func atualizarTela() {
        
        guard let infos = detalhe else { return }

        tituloFilme.text = infos.title
        yearMovieDetalhe.text = getFormattedDate(string: infos.release_date, formatter: "yyyy")
        adultMovieDetalhe.text = infos.adult ? "Adulto" : ""
        overviewMovieDetalhe.attributedText =  boldText(boldText: "Sinopse: ", normalText: infos.overview)
        
        imageMovie.download(from: Constants.baseImageURL + infos.backdrop_path)
    }
    
    
    func boldText(boldText: String, normalText: String) -> NSMutableAttributedString {
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = normalText
        let normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        
        return attributedString
    }
    
    
    func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"

        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
    
}
