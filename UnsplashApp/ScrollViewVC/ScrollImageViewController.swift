//
//  ScrollImageViewController.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 09.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class ScrollImageViewController: UIViewController {
    
    let saveButtom = UIButton()
    let collectionButtom = UIButton()
    let likeButtom = UIButton()
    let imageProfile = UIImageView()
    let infoImage = UIImageView()
    
    var imageScrollView: ImageScrollView!
    var currentImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
        
        let imagePath = Bundle.main.path(forResource: "autumn", ofType: "jpg")!
        currentImage = UIImage(contentsOfFile: imagePath)!
        self.imageScrollView.set(image: currentImage)
        
        self.view.backgroundColor = .black
        
        setupNavigationController()
        
        setupButtomConstraints()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupButtomView()
    }
    
    @objc func back(sender: UIBarButtonItem) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .none
        navigationController?.navigationBar.tintColor = .none
        self.navigationController?.popViewController(animated:true)
    }
    
    @objc func share(sender: UIBarButtonItem) {
        
        let shareController = UIActivityViewController(activityItems: [currentImage], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    private func setupNavigationController() {
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.hidesBackButton = true
        let imageBackBarButtonItem = UIImage(systemName: "arrowshape.turn.up.left.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBackBarButtonItem, style: .plain, target: self, action: #selector(back(sender:)))
        
        let imageRightBarButtonItem = UIImage(systemName: "square.and.arrow.up")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageRightBarButtonItem, style: .plain, target: self, action: #selector(share(sender:)))
        
        self.title = "MorozPavel"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    func setupImageScrollView() {
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    
    func setupButtomView() {
        
        saveButtom.layer.cornerRadius = saveButtom.frame.size.width/2
        saveButtom.clipsToBounds = true
        saveButtom.backgroundColor = .white
        saveButtom.tintColor = .black
        saveButtom.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        
        collectionButtom.layer.cornerRadius = collectionButtom.frame.size.width/2
        collectionButtom.clipsToBounds = true
        collectionButtom.backgroundColor = #colorLiteral(red: 0.1307591796, green: 0.1299891472, blue: 0.1313557923, alpha: 1)
        collectionButtom.tintColor = .white
        collectionButtom.setImage(UIImage(systemName: "plus.rectangle.on.rectangle"), for: .normal)
        
        likeButtom.layer.cornerRadius = likeButtom.frame.size.width/2
        likeButtom.clipsToBounds = true
        likeButtom.backgroundColor = #colorLiteral(red: 0.1307591796, green: 0.1299891472, blue: 0.1313557923, alpha: 1)
        likeButtom.tintColor = .white
        likeButtom.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.clipsToBounds = true
        imageProfile.backgroundColor = .red
        //imageProfile.image = UIImage()
        let imageProfileTap = UITapGestureRecognizer(target: self, action: #selector(self.profileTapped(_:)))
        imageProfile.addGestureRecognizer(imageProfileTap)
        imageProfile.isUserInteractionEnabled = true
        
        infoImage.layer.cornerRadius = infoImage.frame.size.width/2
        infoImage.clipsToBounds = true
        infoImage.image = UIImage(systemName: "info.circle")
        infoImage.tintColor = .white
        let infoImageTap = UITapGestureRecognizer(target: self, action: #selector(self.infoViewTapped(_:)))
        infoImage.addGestureRecognizer(infoImageTap)
        infoImage.isUserInteractionEnabled = true
    }
    
    @objc func profileTapped(_ recognizer: UIGestureRecognizer) {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func infoViewTapped(_ recognizer: UIGestureRecognizer) {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func setupButtomConstraints() {
        view.addSubview(saveButtom)
        view.addSubview(collectionButtom)
        view.addSubview(likeButtom)
        view.addSubview(imageProfile)
        view.addSubview(infoImage)
        
        saveButtom.translatesAutoresizingMaskIntoConstraints = false
        collectionButtom.translatesAutoresizingMaskIntoConstraints = false
        likeButtom.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        
        let radius: CGFloat = 50
        
        NSLayoutConstraint.activate([
            saveButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButtom.heightAnchor.constraint(equalToConstant: radius),
            saveButtom.widthAnchor.constraint(equalToConstant: radius)
        ])
        
        NSLayoutConstraint.activate([
            collectionButtom.bottomAnchor.constraint(equalTo: saveButtom.topAnchor, constant: -20),
            collectionButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionButtom.heightAnchor.constraint(equalToConstant: radius),
            collectionButtom.widthAnchor.constraint(equalToConstant: radius)
        ])
        
        NSLayoutConstraint.activate([
            likeButtom.bottomAnchor.constraint(equalTo: collectionButtom.topAnchor, constant: -20),
            likeButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            likeButtom.heightAnchor.constraint(equalToConstant: radius),
            likeButtom.widthAnchor.constraint(equalToConstant: radius)
        ])
        
        NSLayoutConstraint.activate([
            imageProfile.bottomAnchor.constraint(equalTo: likeButtom.topAnchor, constant: -20),
            imageProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageProfile.heightAnchor.constraint(equalToConstant: radius),
            imageProfile.widthAnchor.constraint(equalToConstant: radius)
        ])
        
        NSLayoutConstraint.activate([
            //infoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            infoImage.bottomAnchor.constraint(equalTo: saveButtom.bottomAnchor),
            infoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoImage.heightAnchor.constraint(equalToConstant: 30),
            infoImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

