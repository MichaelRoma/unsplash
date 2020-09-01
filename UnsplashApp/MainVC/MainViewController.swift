//
//  MainViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 12.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
                                        MainVCItems(imagePath: "")
                                     ])]
    
    var dataSource: UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>?
    var currentSnapshot: NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>?
    
    var collectionView: UICollectionView!
    private var collums = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        createCollectionView()
    }
}

// MARK: pravite func
extension MainViewController {
    private func createCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        collectionView.register(MainVCImageCell.self, forCellWithReuseIdentifier: MainVCImageCell.reuseId)
        
        collectionView.register(MainVCControlCell.self, forCellWithReuseIdentifier: MainVCControlCell.reuseId)
        
        view.addSubview(collectionView)
        createDataSource()
        reloadData()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "first":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCControlCell.reuseId, for: indexPath) as! MainVCControlCell
                cell.delegat = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCImageCell.reuseId, for: indexPath) as! MainVCImageCell
                return cell
            }
        })
    }
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>()
        
        currentSnapshot?.appendSections(sections)
        
        for section in sections {
            currentSnapshot?.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(currentSnapshot!)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (someNumber, layoutEnviroment) -> NSCollectionLayoutSection? in
            let section = self.sections[someNumber]
            switch section.type {
            case "first": return self.createControlSection()
            default:
                return self.createMainSectionGrid2x2()
            }
        }
        return layout
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(166))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    private func createMainSectionGrid2x2() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 13, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(166))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: collums)
        group.interItemSpacing = .fixed(CGFloat(7))
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 0, trailing: 20)
        
        return section
        
    }
    
    private func createControlSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(19))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 14, leading: 22, bottom: 25, trailing: 24)
        
        return section
    }
}

extension MainViewController: SegmentedControllProtocol {
    
    internal func actionSV(cell: MainVCControlCell, index: Int) {
        switch index {
        case 0:
            cell.popularButton.tintColor = .black
            cell.newButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            cell.followButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        case 1:
            cell.popularButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            cell.newButton.tintColor = .black
            cell.followButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        default:
            cell.popularButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            cell.newButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            cell.followButton.tintColor = .black
        }
    }
    
    internal func buttonAction(cell: MainVCControlCell, tag: Int) {
        if tag == 0 {
            cell.buttonFirst.setImage(UIImage(systemName: "rectangle.grid.1x2.fill"), for: .normal)
            cell.buttonFirst.tintColor = .black
            
            cell.buttonSecond.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
            cell.buttonSecond.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            collums = 1
            dataSource?.apply(currentSnapshot!)
            
        } else {
            cell.buttonSecond.setImage(UIImage(systemName: "rectangle.grid.2x2.fill"), for: .normal)
            cell.buttonSecond.tintColor = .black
            
            cell.buttonFirst.setImage(UIImage(systemName: "rectangle.grid.1x2"), for: .normal)
            cell.buttonFirst.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            collums = 2
            dataSource?.apply(currentSnapshot!)
        }
    }
}
