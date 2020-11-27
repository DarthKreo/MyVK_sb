//
//  LikeControl.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 02.11.2020.
//

import UIKit

// MARK: - LikeControl

class LikeControl: UIControl {
    
    //MARK: - Private properties
    
    private lazy var likes = 56
    private lazy var likeButton = HeartButton()
    private lazy var likeCountLabel = UILabel()
    private lazy var stackView = UIStackView()
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    //MARK: - Actions
    
    @objc
    func tapped() {
        if !likeButton.isLiked {
            likes -= 1
            likeCountLabel.textColor = .black
        } else {
            likes += 1
            likeCountLabel.textColor = .red
        }
        likeCountLabel.text = String(likes) + Constants.likeCountLabelText
    }
}

// MARK: - Setup

private extension LikeControl {
    func setupView() {
        addViews()
        addTargets()
        
        setupStackView()
        setupLikeCountLabel()
    }
}

// MARK: - Setups Views

private extension LikeControl {
    func addViews() {
        self.addSubview(stackView)
    }
    
    func addTargets() {
        likeButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    func setupStackView() {
       stackView.addArrangedSubview(likeButton)
       stackView.addArrangedSubview(likeCountLabel)
       stackView.axis = .horizontal
       stackView.distribution = .fillProportionally
   }
    
    func setupLikeCountLabel() {
        likeCountLabel.textColor = .black
        likeCountLabel.text = String(likes) + Constants.likeCountLabelText
        likeCountLabel.adjustsFontSizeToFitWidth = true
    }
}

// MARK: - Constants
private extension LikeControl {
    enum Constants {
        static let likeCountLabelText: String = " likes"
    }
}

