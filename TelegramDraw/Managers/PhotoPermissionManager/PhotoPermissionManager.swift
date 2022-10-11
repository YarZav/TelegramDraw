//
//  PhotoPermissionManager.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

import Photos
import UIKit

public class PhotoPermissionManager: PhotoPermissionManagerProtocol {
  public weak var delegate: PhotoPermissionManagerDelegate?

  public init() { }

  public func performPhotoPermission() {
    let status = PHPhotoLibrary.authorizationStatus()

    switch status {
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization { [weak self] status in
        DispatchQueue.main.async {
          if status == .authorized {
            self?.delegate?.photoPermissionAuthorized()
          }
        }
      }

    case .restricted:
      self.delegate?.photoPermissionRestricted()

    case .denied:
      self.delegate?.photoPermissionDenied()

    case .authorized:
      self.delegate?.photoPermissionAuthorized()

    case .limited:
      self.delegate?.photoPermissionAuthorized()

    @unknown default:
      break
    }
  }

  func isPhotoPermissionAccepted() -> Bool {
    return PHPhotoLibrary.authorizationStatus() == .authorized
  }

  func showAppSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
