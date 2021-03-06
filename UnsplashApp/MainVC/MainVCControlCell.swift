//
//  MainVCControlCell.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//
protocol SegmentedControllProtocol: class {
    func actionSV(cell: MainVCControlCell, index: Int)
    func buttonAction(cell: MainVCControlCell, tag: Int)
}

import UIKit

class MainVCControlCell: UICollectionViewCell {
    
    let buttonFirst = UIButton()
    let buttonSecond = UIButton()
    let nameSegmentedControl = UISegmentedControl(items: ["Popula", "New", "Follow"])
    
    //Три новые кнопки
    let popularButton = UIButton(type: .system)
    let newButton = UIButton(type: .system)
    let followButton = UIButton(type: .system)
    
    
    static let reuseId = "mainControlCell"
    
    weak var delegat: SegmentedControllProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElemenst()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionStyleSegmented(_ sender: UISegmentedControl) {
        let a = sender.selectedSegmentIndex
        delegat?.actionSV(cell: self, index: a)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegat?.buttonAction(cell: self, tag: sender.tag)
    }
    
    @objc private func filterButtonPressed(_ sender: UIButton) {
        delegat?.actionSV(cell: self, index: sender.tag)
    }
}

//MARK: Private methods
extension MainVCControlCell {
    private func setupElemenst() {
        let attributesGray: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1),
            .font: UIFont(name: "HelveticaNeue-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        
        let attributesBlack: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        
        let styleSegment = UISegmentedControl(items: [UIImage(systemName: "rectangle.grid.1x2")!,
                                                      UIImage(systemName: "rectangle.grid.2x2")!
        ])
        
        nameSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        nameSegmentedControl.selectedSegmentTintColor = .clear
        nameSegmentedControl.setTitleTextAttributes(attributesGray, for: .normal)
        nameSegmentedControl.setTitleTextAttributes(attributesBlack, for: .selected)
        nameSegmentedControl.selectedSegmentIndex = 0
        nameSegmentedControl.backgroundColor = .white
        nameSegmentedControl.selectedSegmentTintColor = .white
        nameSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        
        nameSegmentedControl.setWidth(70, forSegmentAt: 0)
        nameSegmentedControl.setWidth(47, forSegmentAt: 1)
        nameSegmentedControl.setWidth(70, forSegmentAt: 2)
        
        nameSegmentedControl.addTarget(self, action: #selector(actionStyleSegmented(_:)), for: .valueChanged)
        
        styleSegment.tintColor = .brown
        styleSegment.backgroundColor = .none
        
        buttonFirst.setImage(UIImage(systemName: "rectangle.grid.1x2.fill"), for: .normal)
        buttonFirst.tintColor = .black
        buttonFirst.tag = 0
        buttonFirst.addTarget(self,action: #selector(buttonPressed), for: .touchUpInside)
        
        buttonSecond.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        buttonSecond.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        buttonSecond.tag = 1
        buttonSecond.addTarget(self,action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        buttonCreation()
        let firstStack = UIStackView(arrangedSubviews: [popularButton, newButton, followButton])
        firstStack.axis = .horizontal
        firstStack.spacing = 14
        
        let secondStack = UIStackView(arrangedSubviews: [buttonFirst, buttonSecond])
        secondStack.axis = .horizontal
        secondStack.spacing = 11
        
        let stack = UIStackView(arrangedSubviews: [firstStack, secondStack])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func buttonCreation() {
        popularButton.setTitle("Popular", for: .normal)
        newButton.setTitle("New", for: .normal)
        followButton.setTitle("Follow", for: .normal)
        
        popularButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        newButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        followButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        
        popularButton.tintColor = .black
        newButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        followButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        
        popularButton.tag = 0
        newButton.tag = 1
        followButton.tag = 2
        
        popularButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        newButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
    }
}
