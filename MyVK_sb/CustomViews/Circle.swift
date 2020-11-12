//
//  Circle.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 31.10.2020.
//

import UIKit

class CircleWithShadow: UIView {

    override class var layerClass: AnyClass { return CAShapeLayer.self }

    override func layoutSubviews() {
        super.layoutSubviews()

        let layer = self.layer as! CAShapeLayer
        layer.strokeColor = nil
        layer.fillColor = UIColor.white.cgColor
        let width: CGFloat = 3
        layer.lineWidth = width
        layer.path = CGPath(ellipseIn: bounds.insetBy(dx: width/2, dy: width/2), transform: nil)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.shadowColor = UIColor.black.cgColor
    }
}
