//
//  ViewController.swift
//  bezierPath
//
//  Created by peter on 2021/8/7.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var demoButton: UIButton!
    @IBOutlet weak var magicCircleView: UIView!
    @IBOutlet weak var magicBackgroundImageView: UIImageView!
    
    let pinkColor = UIColor(red: 0xEB / 0xFF, green: 0x6E / 0xFF, blue: 0xA5 / 0xFF, alpha: 1)
    let pinkshadowColor = UIColor(red: 0xEB / 0xFF, green: 0x6E / 0xFF, blue: 0xA5 / 0xFF, alpha: 1)
    let goldColor = UIColor(red: 0xE6 / 0xFF, green: 0xB4 / 0xFF, blue: 0x2E / 0xFF, alpha: 1)
    let goldshadowColor = UIColor(red: 0xE6 / 0xFF, green: 0xB4 / 0xFF, blue: 0x2E / 0xFF, alpha: 1)
    
    var pinkMagicCircle: [MagicCirclePart : CALayer] = [:]
    var goldMagicCircle: [MagicCirclePart : CALayer] = [:]
    
    let pinkMagicCircleView = UIView()
    let goldMagicCircleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        magicBackgroundImageView.isHidden = true

        pinkMagicCircleView.frame = CGRect(x: 0, y: 0, width: magicCircleView.frame.width, height: magicCircleView.frame.height)
        goldMagicCircleView.frame = CGRect(x: 0, y: 0, width: magicCircleView.frame.width, height: magicCircleView.frame.height)
        magicCircleView.addSubview(pinkMagicCircleView)
        magicCircleView.addSubview(goldMagicCircleView)

        pinkMagicCircle = MagicCirclePart.drawMagicCircle(color: pinkColor, shadowColor: pinkshadowColor)
        for (_, layer) in pinkMagicCircle {
            pinkMagicCircleView.layer.addSublayer(layer)
        }
        pinkMagicCircleView.isHidden = true
        
        
        goldMagicCircle = MagicCirclePart.drawMagicCircle(color: goldColor, shadowColor: goldshadowColor)
        for (_, layer) in goldMagicCircle {
            goldMagicCircleView.layer.addSublayer(layer)
        }
        goldMagicCircleView.isHidden = true
        
        self.view.backgroundColor = UIColor.black
    }
    
    @IBAction func demoButtonEvent(_ sender: Any) {
        pinkMagicCircleAnimation(scale: 0.8)
        goldMagicCircleAnimation(scale: 0.8)
    }
    
    func pinkMagicCircleAnimation(scale: CGFloat) {
        // Show view
        pinkMagicCircleView.isHidden = false
        
        // Configure final result
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, CGFloat(45).radin, 1, 0, 0)
        transform = CATransform3DTranslate(transform, 0, 120, 0)
        transform = CATransform3DScale(transform, scale, scale, scale)
        pinkMagicCircleView.layer.transform = transform
        
        // Start animation
        let multiple: CFTimeInterval = 1.5
        let animation = CABasicAnimation()
        
        animation.fromValue = CGFloat(70).radin
        animation.toValue = CGFloat(45).radin
        animation.duration = 1 * multiple
        animation.repeatCount = 1
        
        animation.keyPath = "transform.rotation.x"
        pinkMagicCircleView.layer.add(animation, forKey: nil)

        animation.fromValue = 0
        animation.toValue = scale
        animation.duration = 1 * multiple
        animation.repeatCount = 1
        animation.keyPath = "transform.scale"
        pinkMagicCircleView.layer.add(animation, forKey: nil)
        
        if let layer = self.pinkMagicCircle[.centerSquqreA] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.pinkMagicCircle[.centerSquqreB] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.pinkMagicCircle[.outerTextRound] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(360).radin
                animation.toValue = CGFloat(0).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.pinkMagicCircle[.centerTextRound] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
    }
    
    func goldMagicCircleAnimation(scale: CGFloat) {
        // Show view
        goldMagicCircleView.isHidden = false
        
        // Configure final result
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, CGFloat(-45).radin, 1, 0, 0)
        transform = CATransform3DTranslate(transform, 0, -50, 0)
        transform = CATransform3DScale(transform, scale, scale, scale)
        goldMagicCircleView.layer.transform = transform

        // Start animation
        let multiple: CFTimeInterval = 1.5
        let animation = CABasicAnimation()
        
        animation.fromValue = CGFloat(0).radin
        animation.toValue = CGFloat(-45).radin
        animation.duration = 1.4 * multiple
        animation.repeatCount = 1
        
        animation.keyPath = "transform.rotation.x"
        goldMagicCircleView.layer.add(animation, forKey: nil)
        
        animation.fromValue = 0
        animation.toValue = scale
        animation.duration = 1 * multiple
        animation.repeatCount = 1
        animation.keyPath = "transform.scale"
        goldMagicCircleView.layer.add(animation, forKey: nil)
        
        if let layer = self.goldMagicCircle[.centerSquqreA] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.goldMagicCircle[.centerSquqreB] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.goldMagicCircle[.outerTextRound] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(360).radin
                animation.toValue = CGFloat(0).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
        
        if let layer = self.goldMagicCircle[.centerTextRound] {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0
            animation.toValue = scale
            animation.duration = 1 * multiple
            animation.repeatCount = 1
            animation.animationComplete {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat(0).radin
                animation.toValue = CGFloat(360).radin
                animation.duration = 10 * multiple
                animation.repeatCount = .infinity
                layer.add(animation, forKey: nil)
            }
            layer.add(animation, forKey: nil)
        }
    }
}

