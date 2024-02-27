//
//  MemoramaViewController.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import UIKit

class MemoramaViewController: UIViewController {
  
  var viewModel : MemoramaViewModel!
  
  var collectionMemorama : MemoramaCollectionView = {
    var collectionView = MemoramaCollectionView()
    
    return collectionView
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    collectionMemorama.delegate = self
    initUI()
    
  }
  
  func initUI(){
    view.addSubview(collectionMemorama)
    collectionMemorama.addAnchorsAndCenter(centerX: true, centerY: true, width: width - 20, height: height / 5, left: nil, top: nil, right: nil, bottom: nil)
  }
  
}

extension MemoramaViewController : MemoramaCollectionViewDelegate{
  func alert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }
  
}
