//
//  PhotoPermissionButton.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

import UIKit

final class PhotoPermissionButton: UIButton {
  private lazy var gradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.type = .axial
    gradient.colors = [
      UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1).cgColor,
      UIColor(red: 82.0 / 255.0, green: 181.0 / 255.0, blue: 248.0 / 255.0, alpha: 1).cgColor,
      UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1).cgColor
    ]
    gradient.startPoint = CGPoint(x: 0, y: 0.20)
    gradient.endPoint = CGPoint(x: 1, y: 0.20)
    gradient.locations = [0, 0.2, 1]
    gradient.cornerRadius = 10
    return gradient
  }()

  override func layoutSubviews() {
    super.layoutSubviews()

    gradient.frame = bounds
    layer.insertSublayer(gradient, at: 0)
  }
}
