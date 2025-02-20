//
//  SkeletonDisplayable.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 16/2/25.
//

import Foundation
import UIKit

// 1
protocol SkeletonDisplayable {
    func showSkeleton()
    func hideSkeleton()
}

// 2
extension SkeletonDisplayable where Self: UIViewController {

    // 3
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }

    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }

    // 4
    private func skeletonViews(in view: UIView) -> [UIView] {
        var results = [UIView]()
        for subview in view.subviews {
            if subview is UILabel || subview is UIImageView || subview is UIButton {
                results.append(subview)
            } else {
                results.append(contentsOf: skeletonViews(in: subview))
            }
        }
        return results
    }

    // 5
    func showSkeleton() {
        let skeletons = skeletonViews(in: view)
        let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor

        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size

        skeletons.forEach { subview in
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = UIScreen.main.bounds
            gradientLayer.name = skeletonGradientName

            subview.layer.mask = skeletonLayer
            subview.layer.addSublayer(skeletonLayer)
            subview.layer.addSublayer(gradientLayer)
            subview.clipsToBounds = true

            let width = UIScreen.main.bounds.width

            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 3
            animation.fromValue = -width
            animation.toValue = width
            animation.repeatCount = .infinity
            animation.autoreverses = false
            animation.fillMode = CAMediaTimingFillMode.forwards

            gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
        }
    }

    // 6
    func hideSkeleton() {
        skeletonViews(in: view).forEach { subview in
            subview.layer.sublayers?.removeAll {
                $0.name == skeletonLayerName || $0.name == skeletonGradientName
            }
        }
    }
}
