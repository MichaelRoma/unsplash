//
//  MainVCImageCell.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class MainVCImageCell: UICollectionViewCell {
    
    static let reuseId = "mainCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurator(with image: UIImage) {
        self.imageView.image = image
    }
}
