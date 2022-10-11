//
//  AppDelegate.swift
//  TelegramDraw
//
//  Created by 19205313 on 08.03.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  private let photoPermissionManager = PhotoPermissionManager()

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = makeNavigationController(with: makeViewController())
    window?.makeKeyAndVisible()
    return true
  }
}

private extension AppDelegate {
  func makeViewController() -> UIViewController {
    if photoPermissionManager.isPhotoPermissionAccepted() {
      return PhotoGalleryViewController()
    } else {
      return PhotoPermissionViewController()
    }
  }

  func makeNavigationController(with viewController: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.isNavigationBarHidden = true
    return navigationController
  }
}
