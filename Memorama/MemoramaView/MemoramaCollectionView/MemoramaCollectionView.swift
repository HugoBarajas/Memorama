//
//  MemoramaCollectionView.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import Foundation
import UIKit

protocol MemoramaCollectionViewDelegate{
  func alert(title: String, message: String)
}

class MemoramaCollectionView : UIView  {
  
  var contadorCorrecto = 0
  
  var contadorIncorrecro = 0
  
  var delegate : MemoramaCollectionViewDelegate?
  
  var ultimaCeldaIndexPath: IndexPath?
  
  var dataSource = [ModelMemorama]()
  
  var collectionViewMemorama : UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    
    var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundColor = .white
    
    return collection
    
  }()
  
  init(){
    super.init(frame: .zero)
    self.backgroundColor = .cyan
    createData()
    initUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func createData(){
    let texto1 = ModelMemorama(NombreEmogi: "⚽️")
    
    
    let texto2 = ModelMemorama(NombreEmogi: "🏀")
    
    let texto3 = ModelMemorama(NombreEmogi: "🏈")
    
    let texto4 = ModelMemorama(NombreEmogi: "⚾️")
    
    let texto5 = ModelMemorama(NombreEmogi: "🎱")
    
    let texto6 = ModelMemorama(NombreEmogi: "⚽️")
    
    let texto7 = ModelMemorama(NombreEmogi: "🏈")
    
    let texto8 = ModelMemorama(NombreEmogi: "🎱")
    
    let texto9 = ModelMemorama(NombreEmogi: "⚾️")
    
    let texto10 = ModelMemorama(NombreEmogi: "🏀")
    
    dataSource.append(contentsOf: [texto1, texto2, texto3, texto4, texto5, texto6, texto7, texto8, texto9, texto10])
    
  }
  
  func initUI(){
    collectionViewMemorama.delegate = self
    collectionViewMemorama.dataSource = self
    collectionViewMemorama.register(MemoramaCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    self.addSubview(collectionViewMemorama)
    collectionViewMemorama.addAnchorsWithMargin(0)
  }
  
}

extension MemoramaCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemoramaCollectionViewCell
    
    let info = dataSource[indexPath.item]
    
    cell.initUI(dataSource: info)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: width / 5, height: height / 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let ultimoIndexPath = ultimaCeldaIndexPath else {
      // Si no hay ninguna celda seleccionada anteriormente, guarda el IndexPath actual y sal del método
      self.ultimaCeldaIndexPath = indexPath
      return
    }
    
    
    let ultimaCelda = collectionView.cellForItem(at: ultimoIndexPath) as? MemoramaCollectionViewCell
    
    let celdaActual = collectionView.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
    
    
    if ultimaCelda!.labelMemorama.text == celdaActual!.labelMemorama.text {
      if ultimaCelda != celdaActual{
        ultimaCelda?.labelOculta.backgroundColor = .clear
        celdaActual?.labelOculta.backgroundColor = .clear
        contadorCorrecto += 2
        contadorIncorrecro -= 2
        print("Llevas estas bien: \(String(contadorCorrecto))")
        if contadorCorrecto == dataSource.count{
          delegate?.alert(title: "Has ganado el juego.", message: "")
          
          contadorCorrecto = 0
          contadorIncorrecro = 0
          reiniciarJuego()
          
        }
        
      }
    }else{
      contadorIncorrecro += 2
      print("Llevas estas mal: \(String(contadorIncorrecro))")
      if contadorIncorrecro >= dataSource.count{
        delegate?.alert(title: "Perdiste.", message: "")
        
        contadorIncorrecro = 0
        contadorCorrecto = 0
        reiniciarJuego()
      }
    }
    // Actualiza el IndexPath de la última celda seleccionada
    self.ultimaCeldaIndexPath = indexPath
  }
  
  func reiniciarJuego(){
    
    let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(cambiarPaVer), userInfo: nil, repeats: false)
    
    collectionViewMemorama.reloadData()
    
    ultimaCeldaIndexPath = nil
  }
  
  @objc func cambiarPaVer(){
    for i in 0..<collectionViewMemorama.numberOfItems(inSection: 0){
      let indexPath = IndexPath(item: i, section: 0)
      let cell = collectionViewMemorama.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
      
      cell?.labelOculta.backgroundColor = .clear
      
      let timer2 = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(cambiarPaNoVer), userInfo: nil, repeats: false)
    }
  }
  
  
  @objc func cambiarPaNoVer(){
    for i in 0..<collectionViewMemorama.numberOfItems(inSection: 0){
      let indexPath = IndexPath(item: i, section: 0)
      let cell = collectionViewMemorama.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
      
      let translucentBlack = UIColor.black.withAlphaComponent(0.9)
      cell?.labelOculta.backgroundColor = translucentBlack
      
    }
  }
  
  
}




