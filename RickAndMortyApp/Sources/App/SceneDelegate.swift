//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        nav.navigationBar.prefersLargeTitles = true
        let coordinator = ApplicationCoordinator(navigationController: nav)
        coordinator.start()
        window.rootViewController = nav
        self.window = window
        self.appCoordinator = coordinator
        window.makeKeyAndVisible()
    }
}
