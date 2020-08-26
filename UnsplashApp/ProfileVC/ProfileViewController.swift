//
//  ProfileViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let sections: [MainVCSection] = [MainVCSection(type: "first", id: 0, items: [
        MainVCItems(imagePath: "")]),
                                     MainVCSection(type: "second", id: 1, items: [
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: "")
                                     ])]
    
    var dataSource: UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "@NolanEd"     
        createCollectionView()
    }
}

//MARK: Private func
extension ProfileViewController {
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .purple
        
        collectionView.register(ProfileCellTop.self, forCellWithReuseIdentifier: ProfileCellTop.reuseId)
        
        collectionView.register(MainVCImageCell.self, forCellWithReuseIdentifier: MainVCImageCell.reuseId)
        
        view.addSubview(collectionView)
        createDataSource()
        reloadData()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "first":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCellTop.reuseId, for: indexPath) as! ProfileCellTop
                cell.delegat = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCImageCell.reuseId, for: indexPath) as! MainVCImageCell
                return cell
            }
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (someNumber, layoutEnviroment) -> NSCollectionLayoutSection? in
            let section = self.sections[someNumber]
            
            switch section.type {
            case "first": return self.createTopSection()
            default:
                return self.createwaterfallSection()
            }
        }
        return layout
    }
    
    private func createTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 33, leading: 41, bottom: 0, trailing: 38)
        return section
    }
    
    private func createwaterfallSection() -> NSCollectionLayoutSection {
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(117))
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(213))
        
        let smallItemLeft = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemLeft.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        let bigItemLeft = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItemLeft.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        let smallItemRight = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemRight.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        let bigItemRight = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItemRight.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [smallItemLeft, bigItemLeft])
        leftGroup.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [bigItemRight, smallItemRight])
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leftGroup, rightGroup])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 24, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}

extension ProfileViewController: ActionManagerForProfileCellTop {
    
    func ButtonAction(cell: ProfileCellTop, tag: Int) {
        switch tag {
        case 0:
            cell.photosButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        case 1:
            cell.photosButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        default:
            cell.photosButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
