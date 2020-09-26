//
//  LabelCell.swift
//  TagsCollectionView
//
//  Created by Alex Paul on 9/25/20.
//

import UIKit

class LabelCell: UICollectionViewCell {
  static let reuseIdentifier = "labelCell"
  
  public lazy var textLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.sizeToFit()
    label.minimumScaleFactor = 0.5
    return label
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
    textLabelConstraints()
    backgroundColor = .systemGreen
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 10
  }
  
  private func textLabelConstraints() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
    ])
  }
  
}
