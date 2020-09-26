//
//  FeedViewController.swift
//  TagsCollectionView
//
//  Created by Alex Paul on 9/25/20.
//

import UIKit

struct Article: Hashable {
  let name: String
  let link: String
  let tags: [String]
  
  static func testData() -> [Article] {
    return [
      Article(name: "Article 1", link: "link1", tags: ["kotlin", "java", "python","javascript"]),
      Article(name: "Article 2", link: "link2", tags: ["swift", "javascript"]),
      Article(name: "Article 3", link: "link3", tags: ["objectiveC"]),
      Article(name: "Article 4", link: "link4", tags: ["php", "perl", "javascript"]),
      Article(name: "Article 5", link: "link5", tags: ["ruby", "python", "javascript"]),
      Article(name: "Article 6", link: "link6", tags: ["swift", "objectiveC", "python"]),
      Article(name: "Article 7", link: "link7", tags: ["javascript", "html", "css", "react"]),
    ]
  }
}

enum Tag: String, CaseIterable, Hashable {
  case python
  case java
  case objectiveC
  case perl
  case javascript
  case swift
  case typescript
  case php
  case ruby
  case kotlin
  case react
  case html
  case css
}

class ArticleFeedController: UIViewController {
  enum SectionKind: Int, CaseIterable {
    case tag, article
    
    var orthogonalBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior {
      switch self {
      case .tag:
        return .continuous
      case .article:
        return .none
      }
    }
  }
  
  private var collectionView: UICollectionView!
  
  typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable> // conforms to Hashable
  private var dataSource: DataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureDataSource()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    collectionView.register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.reuseIdentifier)
    collectionView.backgroundColor = .systemBackground
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.delegate = self
    view.addSubview(collectionView)
  }
  
  private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      guard let sectionType = SectionKind(rawValue: sectionIndex) else {
        fatalError("could not get a section")
      }
      
      let itemWidth: NSCollectionLayoutDimension = sectionIndex == 0 ? .estimated(100) : .fractionalWidth(1.0)
      let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      if sectionType == .tag {
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(8))
      } else {
        let spacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
      }
      
      let groupWidth: NSCollectionLayoutDimension = sectionIndex == 0 ? .estimated(100) : .fractionalWidth(1.0)
      let groupHeight = sectionIndex == 0 ? NSCollectionLayoutDimension.absolute(44) : NSCollectionLayoutDimension.fractionalWidth(0.50)
            
      let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5)
      
      section.orthogonalScrollingBehavior = sectionType.orthogonalBehaviour
            
      return section
    }
    return layout
  }
  
  private func configureDataSource() {
    dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      if indexPath.section == 0 {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell else {
          fatalError("could not dequeue a TagCell")
        }
        cell.textLabel.text = "\(item)"
        return cell
      } else {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.reuseIdentifier, for: indexPath) as? LabelCell else {
          fatalError("could not dequeue a LabelCell")
        }
        cell.textLabel.text = "\(item)"
        return cell
      }
    })
    var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
    snapshot.appendSections([.tag, .article])
    
    let tags: [Tag] = Tag.allCases
    
    let articles: [Article] = Article.testData()
    snapshot.appendItems(tags, toSection: .tag)
    snapshot.appendItems(articles, toSection: .article)
    dataSource.apply(snapshot, animatingDifferences: false)
    
    dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
        fatalError()
      }
      return headerView
    }
  }
}


extension ArticleFeedController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sectionKind = SectionKind(rawValue: indexPath.section),
          let tag = dataSource.itemIdentifier(for: indexPath) as? Tag else {
      return
    }
        
    if sectionKind == .tag {
      let articles = Article.testData().filter { $0.tags.contains(tag.rawValue) }
      showAlert(with: "\(tag.rawValue.capitalized) Articles", message: "\(articles.count) articles found.")
    }
  }
}


extension UIViewController {
  func showAlert(with title: String?, message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
}
