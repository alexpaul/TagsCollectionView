//
//  TagCell.swift
//  TagsCollectionView
//
//  Created by Alex Paul on 9/25/20.
//

import UIKit

public class PaddedLabel: UILabel {
  @IBInspectable var topInset: CGFloat = 5.0
  @IBInspectable var bottomInset: CGFloat = 5.0
  @IBInspectable var leftInset: CGFloat = 7.0
  @IBInspectable var rightInset: CGFloat = 7.0
  
  public override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  
  public override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset,
                  height: size.height + topInset + bottomInset)
  }
  
  public override func sizeToFit() {
    super.sizeThatFits(intrinsicContentSize)
  }
}

class TagCell: UICollectionViewCell {
  static let reuseIdentifier = "tagCell"
  
  public lazy var textLabel: PaddedLabel = {
    let label = PaddedLabel()
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
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
    backgroundColor = .systemTeal
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 10
  }
  
  private func textLabelConstraints() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}

