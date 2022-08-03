//
//  MainCoordinator.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewControllerProvider.searchViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func displaySaveBooks(of savedBooksManager: SavedBooksManager) {
        let savedBooksVC = ViewControllerProvider.savedBooksViewController(for: savedBooksManager)
        savedBooksVC.coordinator = self
        navigationController.pushViewController(savedBooksVC, animated: true)
    }
}
