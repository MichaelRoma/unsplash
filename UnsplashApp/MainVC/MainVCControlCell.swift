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
    let historyButton = UIButton(type: .system)
    let athleticsButton = UIButton(type: .system)
    let technologyButton = UIButton(type: .system)

    weak var refreshDelegate: MainViewControllerUpdateDataDelegate?
    
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
        switch sender.tag {
        case 0:
            UserDefaults.standard.setOrderRequest(value: Order.latest.rawValue)
        case 1:
            UserDefaults.standard.setOrderRequest(value: Order.oldest.rawValue)
        case 2:
            UserDefaults.standard.setOrderRequest(value: Order.popular.rawValue)

        default:
            UserDefaults.standard.setOrderRequest(value: Order.latest.rawValue)
        }

        refreshDelegate?.refreshData()

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
        let firstStack = UIStackView(arrangedSubviews: [historyButton, athleticsButton, technologyButton])
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
        historyButton.setTitle("History", for: .normal)
        athleticsButton.setTitle("Athletics", for: .normal)
        technologyButton.setTitle("Technology", for: .normal)
        
        historyButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        athleticsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        technologyButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        
        historyButton.tintColor = .black
        athleticsButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        technologyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)

        if UserDefaults.standard.getOrderRequest() == Order.latest.rawValue {
            historyButton.tintColor = .black
            athleticsButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            technologyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        } else if UserDefaults.standard.getOrderRequest() == Order.oldest.rawValue {

            historyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            athleticsButton.tintColor = .black
            technologyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        } else if UserDefaults.standard.getOrderRequest() == Order.popular.rawValue {

            historyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            athleticsButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            technologyButton.tintColor = .black
        } else {
            historyButton.tintColor = .black
            athleticsButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
            technologyButton.tintColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        }
        
        historyButton.tag = 0
        athleticsButton.tag = 1
        technologyButton.tag = 2
        
        historyButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        athleticsButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
        technologyButton.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)
    }
}
