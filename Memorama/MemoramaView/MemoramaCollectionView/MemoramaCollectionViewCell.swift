//
//  MemoramaCollectionViewCell.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import UIKit

class MemoramaCollectionViewCell: UICollectionViewCell {
  
  var dataSource : ModelMemorama?
  
  var labelMemorama : UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30)
    
    return label
  }()
  
  var labelOculta : UILabel = {
    var label = UILabel()
    
    label.backgroundColor = .clear
    
    return label
    
  }()
  
  override init(frame : CGRect) {
    super.init(frame: .zero)
    self.backgroundColor = .white
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initUI(dataSource : ModelMemorama){
    labelMemorama.text = dataSource.NombreEmogi
    let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(cambioLabel), userInfo: nil, repeats: false)
    
    self.addSubview(labelMemorama)
    labelMemorama.addAnchorsWithMargin(0)
    
    self.addSubview(labelOculta)
    labelOculta.addAnchorsWithMargin(0)
  }
  
  
  @objc func cambioLabel(){
    let translucentBlack = UIColor.black.withAlphaComponent(0.9)
    labelOculta.backgroundColor = translucentBlack
  }
}





