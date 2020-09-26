# TagsCollectionView

Adding a tags view using collection view compositional layout.

In this demo app `UICollectionViewCompositionalLayout` is used to compose two sections. The first section has a series of tags configured to scroll horizontally and the second section renders a vertical section layout. 

The `ItemIdentifiers` are of different types, namely a `Tag` type and an `Article` type.

The `UICollectionDiffableDataSource` is made to work with both types by making the `ItemIdentifier` a `AnyHashable` type. 

```swift 
UICollectionViewDiffableDataSource<SectionKind, AnyHashable> 
```

In the data soruce configuration the types are type cast accordingly and the snapshot applied. 

```swift 
var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
snapshot.appendSections([.tag, .article])

let tags: [Tag] = Tag.allCases
let articles: [Article] = Article.testData()
snapshot.appendItems(tags, toSection: .tag)
snapshot.appendItems(articles, toSection: .article)
dataSource.apply(snapshot, animatingDifferences: false)
```

![tags collection view](Assets/tags-collection-view.gif)
