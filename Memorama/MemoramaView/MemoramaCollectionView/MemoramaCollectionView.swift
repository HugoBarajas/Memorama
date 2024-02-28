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
  
  var dataEmogis = [String]()
  
  var contadorCorrecto = 0
  
  var contadorIncorrecro = 0
  
  var delegate : MemoramaCollectionViewDelegate?
  
  var ultimaCeldaIndexPath: IndexPath?
  
  var collectionViewMemorama : UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    
    var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundColor = .white
    
    return collection
    
  }()
  
  init(){
    super.init(frame: .zero)
    self.backgroundColor = .cyan
    initUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func receiveData(info : [String]){
    self.dataEmogis = info
    print("ya llegue \(dataEmogis)")
    collectionViewMemorama.reloadData()
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
    dataEmogis.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemoramaCollectionViewCell
    
    let info = dataEmogis[indexPath.item]
    
    cell.initUI(dataSource: info)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: width / 2.12, height: height / 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let ultimoIndexPath = ultimaCeldaIndexPath else {
      // Si no hay ninguna celda seleccionada anteriormente, guarda el IndexPath actual y sal del método
      self.ultimaCeldaIndexPath = indexPath
      if let cell = collectionView.cellForItem(at: indexPath) as? MemoramaCollectionViewCell {
        cell.labelOculta.backgroundColor = .clear
      }
      return
    }
    
    
    let ultimaCelda = collectionView.cellForItem(at: ultimoIndexPath) as? MemoramaCollectionViewCell
  
    
    let celdaActual = collectionView.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
    
    
    if ultimaCelda!.labelMemorama.text == celdaActual!.labelMemorama.text {
      if ultimaCelda != celdaActual{
       
        ultimaCelda?.labelOculta.backgroundColor = .clear
       
        celdaActual?.labelOculta.backgroundColor = .clear
     
        contadorCorrecto += 2
        
        
        print("Llevas estas bien: \(String(contadorCorrecto))")
          if contadorCorrecto == dataEmogis.count{
            delegate?.alert(title: "Has ganado el juego.", message: "")
            self.ultimaCeldaIndexPath = nil
            contadorCorrecto = 0
            contadorIncorrecro = 0
            reiniciarJuego()
          
          }else if contadorCorrecto <= dataEmogis.count{
            delegate?.alert(title: "Vas bien", message: "")
          }
        
      }
    }else{
      contadorIncorrecro += 2
      
      celdaActual?.labelOculta.backgroundColor = .black
      
      ultimaCelda?.labelOculta.backgroundColor = .black
      
      print("Llevas estas mal: \(String(contadorIncorrecro))")
      
      if contadorIncorrecro == dataEmogis.count{
        delegate?.alert(title: "Perdiste.", message: "")
        
        contadorIncorrecro = 0
        contadorCorrecto = 0
        reiniciarJuego()
      }else if contadorIncorrecro <= dataEmogis.count{
        delegate?.alert(title: "No son las mismas", message: "")
      }
    }
    // Actualiza el IndexPath de la última celda seleccionada
    self.ultimaCeldaIndexPath = nil
  }
  
  
  
  func reiniciarJuego(){
    
    let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(cambiarPaVer), userInfo: nil, repeats: false)
    
    collectionViewMemorama.reloadData()
  
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




