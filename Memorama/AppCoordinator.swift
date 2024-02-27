//
//  AppCoordinator.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import Foundation
import UIKit

protocol Coordinator{
  var childCoordinator : [Coordinator] {get set}
  func StartCoordinator()
}

class AppCoordinator : Coordinator{
  var childCoordinator: [Coordinator] = []
  
  var window : UIWindow
  
  init(window: UIWindow) {
    
    self.window = window
  }
  
  func StartCoordinator() {
    let navigationController = UINavigationController()
    let startMemoramaCoordinator = MemoramaCoordinator(navigationController: navigationController)
    startMemoramaCoordinator.StartCoordinator()
    childCoordinator.append(startMemoramaCoordinator)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
}
