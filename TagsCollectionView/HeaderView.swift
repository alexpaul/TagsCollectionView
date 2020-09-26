//
//  HeaderView.swift
//  TagsCollectionView
//
//  Created by Alex Paul on 9/25/20.
//

import UIKit

class HeaderView: UICollectionReusableView {
  
  static let reuseIdentifier = "headerView"
  
  public lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "photo")
    iv.layer.cornerRadius = 8
    iv.clipsToBounds = true
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imageViewConstraints()
  }
  
  private func imageViewConstraints() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
