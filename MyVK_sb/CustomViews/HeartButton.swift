//
//  HeartButton.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 02.11.2020.
//

import UIKit

// MARK: - HeartButton

class HeartButton: UIButton {
    
    //MARK: - Private properties
    
    private lazy var unlikedImage = UIImage(named: "heartempty")
    private lazy var likedImage = UIImage(named: "heart")
    
    private lazy var unlikedScale: CGFloat = 0.7
    private lazy var likedScale: CGFloat = 1.3
    
    // MARK: - Public properties
    
    public var isLiked = false
    
    // MARK: - init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(unlikedImage, for: .normal)
        self.addTarget(self, action: #selector(flipLikedState), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    @objc
    public func flipLikedState() {
        isLiked = !isLiked
        animate()
    }
    
    //MARK: - Private methods
    
    private func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
