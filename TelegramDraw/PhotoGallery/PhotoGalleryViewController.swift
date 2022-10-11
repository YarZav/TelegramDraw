//
//  PhotoGalleryViewController.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
  }
}

// MARK: - Private

private extension PhotoGalleryViewController {
  func createUI() {
    view.backgroundColor = .black
  }
}
