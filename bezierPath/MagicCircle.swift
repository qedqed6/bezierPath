//
//  MagicCircle.swift
//  bezierPath
//
//  Created by peter on 2021/8/15.
//

import Foundation
import UIKit

enum MagicCirclePart {
    case outerCircle
    case innerCircle
    
    case centerCircle
    case centerSquqreA
    case centerSquqreB
    
    case outerTextRound
    case centerTextRound
    
    static func drawMagicCircle(color: UIColor, shadowColor: UIColor) -> [MagicCirclePart : CALayer] {
        var magicCircleLayers: [MagicCirclePart : CALayer] = [:]
        
        magicCircleLayers[.outerCircle] =
            doubleCircle(center: CGPoint(x: 200, y: 200),
                         radius: 200,
                         distance: 12,
                         lineWidth: 2,
                         color: color,
                         shadowColor: shadowColor)

        magicCircleLayers[.innerCircle] =
            doubleCircle(center: CGPoint(x: 200, y: 200),
                         radius: 188,
                         distance: 50,
                         lineWidth: 2,
                         color: color,
                         shadowColor: shadowColor)

        magicCircleLayers[.centerCircle] =
            doubleCircle(center: CGPoint(x: 200, y: 200),
                         radius: 96,
                         distance: 30,
                         lineWidth: 2,
                         color: color,
                         shadowColor: shadowColor)

        magicCircleLayers[.centerSquqreA] =
            singleSquare(location: CGPoint(x: 65, y: 65),
                         angle: 45,
                         width: 190,
                         lineWidth: 2,
                         color: color,
                         shadowColor: shadowColor)

        magicCircleLayers[.centerSquqreB] =
            singleSquare(location: CGPoint(x: 65, y: 65),
                         angle: 90,
                         width: 190,
                         lineWidth: 2,
                         color: color,
                         shadowColor: shadowColor)

        magicCircleLayers[.outerTextRound] =
            magicTextRound(center: CGPoint(x: 200, y: 200),
                           radius: 170,
                           color: color,
                           fontSize: 45,
                           subCircle: true)
        
        magicCircleLayers[.centerTextRound] =
            magicTextRound(center: CGPoint(x: 200, y: 200),
                           radius: 84,
                           color: color,
                           fontSize: 20,
                           subCircle: false)
        
        return magicCircleLayers
    }
}

func magicTextRound(center: CGPoint,
                    radius: CGFloat,
                    color: UIColor,
                    fontSize: CGFloat,
                    subCircle: Bool) -> CALayer {
    let layer = CALayer()
    layer.frame = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    let layerCenter = CGPoint(x: layer.frame.width / 2, y: layer.frame.height / 2)
    
    if subCircle {
        for index in 0...3 {
            let x = (radius - (fontSize / 4.8)) * CGFloat(cos(Double(CGFloat(index * 90).radin))) + layerCenter.x
            let y = (radius - (fontSize / 4.8)) * CGFloat(sin(Double(CGFloat(index * 90).radin))) + layerCenter.y

            layer.addSublayer(doubleCircle(center: CGPoint(x: x, y: y),
                                           radius: fontSize / 1.8,
                                           distance: 3,
                                           lineWidth: 1,
                                           color: color))
        }
    }
    
    layer.addSublayer(circleString(center: layerCenter,
                                   radius: radius,
                                   startAngle: 0,
                                   offsetAngle: 30,
                                   color: color,
                                   string: "τ  ω  ν  π",
                                   fontSize: fontSize,
                                   rotate: true))

    layer.addSublayer(circleString(center: layerCenter,
                                   radius: radius,
                                   startAngle: 12.5,
                                   offsetAngle: 4.5,
                                   color: color,
                                   string: "takamachinanoha",
                                   fontSize: fontSize,
                                   rotate: true))

    layer.addSublayer(circleString(center: layerCenter,
                                   radius: radius,
                                   startAngle: 90 + 13.5,
                                   offsetAngle: 4.5,
                                   color: color,
                                   string: "fate testarossa",
                                   fontSize: fontSize,
                                   rotate: true))
    
    layer.addSublayer(circleString(center: layerCenter,
                                   radius: radius,
                                   startAngle: 180 + 17,
                                   offsetAngle: 4.5,
                                   color: color,
                                   string: "yagami hayate",
                                   fontSize: fontSize,
                                   rotate: true))
    
    layer.addSublayer(circleString(center: layerCenter,
                                   radius: radius,
                                   startAngle: 270 + 16,
                                   offsetAngle: 4.5,
                                   color: color,
                                   string: "takamachivivio",
                                   fontSize: fontSize,
                                   rotate: true))
    
    return layer
}

func circleString(center: CGPoint,
                  radius: CGFloat,
                  startAngle: CGFloat,
                  offsetAngle: CGFloat,
                  color: UIColor,
                  string: String,
                  fontSize: CGFloat,
                  rotate: Bool,
                  auxiliaryLine: Bool = false) -> CALayer {
    let layer = CALayer()
    layer.frame = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)

    if auxiliaryLine {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 2
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.green.cgColor
        shape.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        layer.addSublayer(shape)
    }
    
    for (index, characater) in string.enumerated() {
        if String(characater) == " " {
            continue
        }
        
        let currentAngle: CGFloat = startAngle + (CGFloat(index) * offsetAngle)
        
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0, y: 0, width: fontSize, height: fontSize)
        
        let x: CGFloat = (radius * cos(Double(currentAngle.radin))) + radius - CGFloat(fontSize / 2)
        let y: CGFloat = (radius * sin(Double(currentAngle.radin))) + radius - CGFloat(fontSize / 2)
        textLayer.frame = CGRect(x: x, y: y, width: fontSize, height: fontSize)

        textLayer.fontSize = fontSize
        textLayer.foregroundColor = color.cgColor
        textLayer.alignmentMode = .center
        textLayer.string = String(characater)
        
        if rotate {
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            textLayer.transform = CATransform3DRotate(transform, currentAngle.radin - (3 * CGFloat.pi / 2), 0, 0, 1)
        }
        
        if auxiliaryLine {
            textLayer.backgroundColor = UIColor.yellow.cgColor
            textLayer.opacity = 0.5
        }
        
        layer.addSublayer(textLayer)
    }
    
    return layer
}

func singleSquare(location: CGPoint,
                  angle: CGFloat,
                  width: CGFloat,
                  lineWidth: CGFloat,
                  color: UIColor,
                  shadowColor: UIColor? = nil) -> CAShapeLayer {
    let radius: CGFloat = (width * CGFloat(sqrt(2))) / 2
    let radin: CGFloat = angle * CGFloat.pi / 180
    let path = UIBezierPath()
    
    var x: CGFloat = radius * cos(Double(radin)) + radius
    var y: CGFloat = radius * sin(Double(radin)) + radius
    path.move(to: CGPoint(x: x, y: y))

    for index in 1...3 {
        x = radius * cos(Double(radin + (Double(index) * (CGFloat.pi / 2)))) + radius
        y = radius * sin(Double(radin + (Double(index) * (CGFloat.pi / 2)))) + radius
        path.addLine(to: CGPoint(x: x, y: y))
    }
    path.close()
    
    let shape = CAShapeLayer()
    shape.path = path.cgPath
    shape.lineWidth = lineWidth
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = color.cgColor
    shape.frame = CGRect(x: location.x, y: location.y, width: radius * 2, height: radius * 2)
    
    if let shadowColor = shadowColor {
        shape.shadowColor = shadowColor.cgColor
        shape.shadowOpacity = 1
        shape.shadowOffset = CGSize(width: 0, height: 3)
        shape.shadowRadius = 4.0
    }
    
    return shape
}

func doubleCircle(center: CGPoint,
                  radius: CGFloat,
                  distance: CGFloat,
                  lineWidth: CGFloat,
                  color: UIColor,
                  shadowColor: UIColor? = nil) -> CAShapeLayer {
    let shape = CAShapeLayer()
    shape.frame = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    let shapeCenter = CGPoint(x: shape.frame.width / 2, y: shape.frame.height / 2)
    
    let path = UIBezierPath()
    let outerCircleStartPoint = CGPoint(x: shapeCenter.x, y: (shapeCenter.y - radius) + lineWidth)
    let innerCircleStartPoint = CGPoint(x: shapeCenter.x, y: (shapeCenter.y - radius) + lineWidth + distance)
    
    // outer circle
    path.move(to: outerCircleStartPoint)
    path.addArc(withCenter: shapeCenter, radius: radius - lineWidth, startAngle:  -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: true)
    
    // inner circle
    path.move(to: innerCircleStartPoint)
    path.addArc(withCenter: shapeCenter, radius: radius - distance - lineWidth, startAngle:  -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: true)
    
    shape.path = path.cgPath
    shape.lineWidth = lineWidth
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = color.cgColor

    if let shadowColor = shadowColor {
        shape.shadowColor = shadowColor.cgColor
        shape.shadowOpacity = 1
        shape.shadowOffset = CGSize(width: 0, height: 3)
        shape.shadowRadius = 4.0
    }
    
    return shape
}
