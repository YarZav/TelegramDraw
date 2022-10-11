//
//  CameraPermissionManagerProtocol.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

protocol PhotoPermissionManagerProtocol {
  var delegate: PhotoPermissionManagerDelegate? { get set }

  func performPhotoPermission()
  func isPhotoPermissionAccepted() -> Bool
  func showAppSettings()
}

extension PhotoPermissionManagerProtocol {
  func performPhotoPermission() {
    fatalError("Need emplementation")
  }

  func isPhotoPermissionAccepted() -> Bool {
    fatalError("Need emplementation")
  }

  func showAppSettings() {
    fatalError("Need emplementation")
  }
}

public protocol PhotoPermissionManagerDelegate: AnyObject {
  func photoPermissionRestricted()
  func photoPermissionAuthorized()
  func photoPermissionNotDetermined()
  func photoPermissionDenied()
}
