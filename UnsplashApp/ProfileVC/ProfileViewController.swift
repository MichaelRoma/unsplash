//
//  ProfileViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
       // navigationController?.title = "@NolanEd"
    title =  "@NolanEd"
            //   navigationController?.tabBarItem.title = "@NolanEd"
     
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
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            self.createTopSection()
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
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCellTop.reuseId, for: indexPath) as! ProfileCellTop
        cell.backgroundColor = .cyan
        return cell
    }
    
    
}
