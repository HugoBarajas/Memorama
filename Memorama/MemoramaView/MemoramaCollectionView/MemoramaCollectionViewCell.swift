//
//  MemoramaCollectionViewCell.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import UIKit

class MemoramaCollectionViewCell: UICollectionViewCell {
  
  var dataSource : String?
  
  var labelMemorama : UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30)
    
    return label
  }()
  
  var labelOculta : UILabel = {
    var label = UILabel()
    label.font = .systemFont(ofSize: 30)
    label.backgroundColor = .clear
    label.text = "?"
    label.textAlignment = .center
    label.textColor = .white
    return label
    
  }()
  
  override init(frame : CGRect) {
    super.init(frame: .zero)
    self.backgroundColor = .lightGray
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initUI(dataSource : String){
    labelMemorama.text = dataSource
    
    self.addSubview(labelMemorama)
    labelMemorama.addAnchorsWithMargin(0)
    
    self.addSubview(labelOculta)
    labelOculta.addAnchorsWithMargin(0)
  }

}





