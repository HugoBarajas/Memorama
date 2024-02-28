//
//  MemoramaViewController.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import UIKit

class MemoramaViewController: UIViewController {
  
  var dataEmogis = [String]()
  
  
  var textFieldPares : UITextField = {
    var textField = UITextField()
    textField.placeholder = "Numero de pares"
    textField.backgroundColor = .white
    textField.textContentType = .oneTimeCode
    
    return textField
  }()
  
  var viewModel : MemoramaViewModel!
  
  var collectionMemorama : MemoramaCollectionView = {
    var collectionView = MemoramaCollectionView()
    
    return collectionView
    
  }()
  
  var buttonInicio : UIButton = {
    var button = UIButton()
    button.setTitle("Inicio", for: .normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = .systemGreen
    button.layer.borderWidth = 5
    return button
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    collectionMemorama.delegate = self
    
    initUI()
    
  }
  
  func initUI(){
  
    view.addSubview(textFieldPares)
    textFieldPares.addAnchorsAndCenter(centerX: true, centerY: false, width: width - 60, height: height / 15, left: nil, top: 80, right: nil, bottom: nil)
    
    view.addSubview(collectionMemorama)
    collectionMemorama.addAnchorsAndCenter(centerX: true, centerY: true, width: width - 20, height: height / 2, left: nil, top: nil, right: nil, bottom: nil)
    
    buttonInicio.addTarget(self, action: #selector(createDataa), for: .touchUpInside)
    view.addSubview(buttonInicio)
    buttonInicio.addAnchorsAndCenter(centerX: true, centerY: false, width: 80, height: 50, left: nil, top: nil, right: nil, bottom: 50)
  }
  
  func SoloNumero(numero : String) -> Bool{
    let numbersRegex = "^[0-9]+$"
    let numbersPredicade = NSPredicate(format: "SELF MATCHES %@", numbersRegex)
    
    return numbersPredicade.evaluate(with: numero)
    
  }
  
  func createData(numerosDePares : String) {
    if SoloNumero(numero: numerosDePares){
      let numero = Int(numerosDePares) ?? 0
      if numero >= 2 && numero <= 20{
        for i in 0..<numero{
          let emogis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉", "🥏", "🎱", "🏓","🥊", "🍏", "🍎", "🍉", "🥑","🍇","🍔","🍕", "🥪","🌮"]
          
          dataEmogis.append(emogis[i])
          dataEmogis.append(emogis[i])
        }
        dataEmogis.shuffle()
        
      }else {
        alert(title: "El numero de pares introducido no es valido.", message: "")
        textFieldPares.text = ""
      }
      
    }else{
      alert(title: "No puedes meter caracteres no numericos.", message: "")
      textFieldPares.text = ""
    }
  }
  
  func reiniciarJuego(){
    
    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cambiarPaVer), userInfo: nil, repeats: false)
    
  
  }
  
  @objc func createDataa(){
    
    dataEmogis.removeAll()
    createData(numerosDePares: textFieldPares.text!)
  
    collectionMemorama.receiveData(info: dataEmogis)
    collectionMemorama.collectionViewMemorama.reloadData()
    reiniciarJuego()
    
  }
  @objc func cambiarPaVer(){
    for i in 0..<collectionMemorama.collectionViewMemorama.numberOfItems(inSection: 0){
      let indexPath = IndexPath(item: i, section: 0)
      let cell = collectionMemorama.collectionViewMemorama.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
      
      cell?.labelOculta.backgroundColor = .clear
      
      let timer2 = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(cambiarPaNoVer), userInfo: nil, repeats: false)
    }
  }
  
  
  @objc func cambiarPaNoVer(){
    for i in 0..<collectionMemorama.collectionViewMemorama.numberOfItems(inSection: 0){
      let indexPath = IndexPath(item: i, section: 0)
      let cell = collectionMemorama.collectionViewMemorama.cellForItem(at: indexPath) as? MemoramaCollectionViewCell
      
      let translucentBlack = UIColor.black.withAlphaComponent(0.9)
      cell?.labelOculta.backgroundColor = translucentBlack
      
    }
  }
  
}

extension MemoramaViewController : MemoramaCollectionViewDelegate{
  func alert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }
  
}


/*
 hacer un textField en el que se introduzca el numero de pares que se van a mostrar en el collection, al momento de darle click al botton, se va a mostrar el collection, igualmente lo que se va a hacer es que si se tienen mas de dos pares, se tienen el numero de pares mas uno de oportunidades, si se tienen solo 2 pares se tienen 2 oportunidades
 */
