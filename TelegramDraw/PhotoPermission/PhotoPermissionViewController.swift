//
//  PhotoPermissionViewController.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

import UIKit

final class PhotoPermissionViewController: UIViewController {
  private lazy var photoPermissionManager: PhotoPermissionManagerProtocol = {
    let manager = PhotoPermissionManager()
    manager.delegate = self
    return manager
  }()

  private lazy var containerView = UIView()

  private lazy var imageView: UIImageView = {
    let image = UIImage(named: "duck")
    let imageView = UIImageView(image: image)
    return imageView
  }()

  private lazy var label: UILabel = {
    let label = UILabel()
    label.text = "Access Your Photos and Videos"
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.textColor = .white
    return label
  }()

  private lazy var button: UIButton = {
    let button = PhotoPermissionButton()
    button.setTitle("Allow Access", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
  }
}

// MARK: - Private

private extension PhotoPermissionViewController {
  func createUI() {
    view.backgroundColor = .black

    view.addSubview(containerView)
    containerView.addSubview(imageView)
    containerView.addSubview(label)
    containerView.addSubview(button)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

      imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 144),
      imageView.heightAnchor.constraint(equalToConstant: 144),

      label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
      label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

      button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 28),
      button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      button.heightAnchor.constraint(equalToConstant: 50),
      button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
}

// MARK: - Action

private extension PhotoPermissionViewController {
  @objc
  func buttonTapped(sender: UIButton) {
    photoPermissionManager.performPhotoPermission()
  }
}

// MARK: - PhotoPermissionManagerDelegate

extension PhotoPermissionViewController: PhotoPermissionManagerDelegate {
  func photoPermissionRestricted() { }
  
  func photoPermissionAuthorized() {
    let photoGalleryViewController = PhotoGalleryViewController()
    navigationController?.setViewControllers([photoGalleryViewController], animated: true)
  }
  
  func photoPermissionNotDetermined() { }
  
  func photoPermissionDenied() {
    let title = "Permissions for photo gallery was denied"
    let message = "Do you want to open settings and accept permissions for photo gallery?"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let yesAlertAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
      self?.photoPermissionManager.showAppSettings()
    }
    let noAlertAction = UIAlertAction(title: "No", style: .cancel)
    alertController.addAction(yesAlertAction)
    alertController.addAction(noAlertAction)
    present(alertController, animated: true)
  }
}
