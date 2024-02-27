//
//  MemoramaCoordinator.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import Foundation
import UIKit

class MemoramaCoordinator : Coordinator{
  var childCoordinator: [Coordinator] = []
  var navigationController : UINavigationController
  
  init(navigationController: UINavigationController) {
    
    self.navigationController = navigationController
  }
  func StartCoordinator() {
    let view = MemoramaViewController()
    let viewModel = MemoramaViewModel()
    viewModel.coordinator = self
    view.viewModel = viewModel
    
    navigationController.setViewControllers([view], animated: true)
  }
  
}
