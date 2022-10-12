//
//  PhotoGalleryViewController.swift
//  GitHubExample
//
//  Created by Yaroslav Zavyalov on 10/11/22.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {
  private var scale: CGFloat = 1.0
  private lazy var scaleStart: CGFloat = scale

  var collectionViewFlowLayout: UICollectionViewFlowLayout {
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionViewFlowLayout.scrollDirection = .vertical
    collectionViewFlowLayout.minimumInteritemSpacing = 2
    collectionViewFlowLayout.minimumLineSpacing = 2
    return collectionViewFlowLayout
  }

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.alwaysBounceVertical = true
    collectionView.isScrollEnabled = true
    return collectionView
  }()

  private lazy var gesture = UIPinchGestureRecognizer(target: self, action: #selector(didReceivePinchGesture))

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
  }
}

// MARK: - Private

private extension PhotoGalleryViewController {
  func createUI() {
    view.backgroundColor = .black

    view.addSubview(collectionView)
    collectionView.addGestureRecognizer(gesture)

    collectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

private extension PhotoGalleryViewController {
  @objc
  func didReceivePinchGesture(_ gesture: UIPinchGestureRecognizer) {
    if gesture.state == .began {
      scaleStart = scale
      return
    }

    if gesture.state == .ended {
      gesture.scale = 1
      return
    }

    if gesture.state == .changed {
      scale = scaleStart * pow(gesture.scale, 4)

      collectionView.removeGestureRecognizer(gesture)
      let newLayout = collectionViewFlowLayout
      collectionView.setCollectionViewLayout(newLayout, animated: true) { [weak self] _ in
        guard let self = self else { return }
        self.collectionView.addGestureRecognizer(self.gesture)
      }
    }
  }
}

extension PhotoGalleryViewController: UICollectionViewDelegate {
  
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    100
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.red : UIColor.blue
    return cell
  }
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = view.bounds.width
    let scaledWidth = width * scale

    if scaledWidth > width {
      scale = 1
      return CGSize(width: width, height: width)
    }

    let smallWidth = width / 13
    if scaledWidth < smallWidth {
      scale = 0.075
      return CGSize(width: smallWidth, height: smallWidth)
    }

    let cols: CGFloat = floor(width / scaledWidth)
    let totalSpacingSize = 2 * (cols - 1)
    let fittedWidth = (width - totalSpacingSize) / cols

    return CGSize(width: fittedWidth, height: fittedWidth)
  }
}
