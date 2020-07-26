//
//  SceneDelegate.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 12/07/2020.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let contentView = ContentView().environment(\.managedObjectContext, context)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: contentView
                    .environmentObject(GameContentController(context))
                    .environmentObject(ViewRouter())
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

