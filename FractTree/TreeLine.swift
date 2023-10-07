//
//  TreeLine.swift
//  FractTree
//
//  Created by LUIS FELIPE B PEREIRA on 07/10/23.
//

import Foundation
import UIKit

class TreeLine  {
    var origin: CGPoint = .zero
    var end: CGPoint = .zero
    var length: CGFloat = 0.0
    var angle: CGFloat = 0.0
    var shape = CAShapeLayer()
    var animation = CABasicAnimation(keyPath: "strokeEnd")
    
    init(origin: CGPoint, end: CGPoint) {
        self.origin = origin
        self.end = end
        shape.fillColor = UIColor.clear.cgColor
    }
    
    init(origin: CGPoint, length: CGFloat, angle: CGFloat) {
        self.origin = origin
        self.length = length
        self.angle = angle
        shape.fillColor = UIColor.clear.cgColor
        end.x = origin.x + length*cos(angle)
        end.y = origin.y + length*sin(angle)
    }
    
    func draw(inside view: UIView) {
        
        let path = makePath()
        shape = CAShapeLayer()
        shape.path = path.cgPath
        setLineColor(.black)
        setLineWidth(2)
        animate()
        view.layer.addSublayer(shape)
    }
    
    func setLineColor(_ color: UIColor) {
        shape.strokeColor = color.cgColor
    }
    
    func setLineWidth(_ w: CGFloat) {
        shape.lineWidth = w
    }
    
    func createRightLine() -> TreeLine {
        let origin = self.end
        let length = self.length*0.8
        let angle = self.angle - Double.pi/12
        let line =  TreeLine(origin: origin, length: length, angle: angle)
        return line
    }
    
    func createLeftLine() -> TreeLine {
        let origin = self.end
        let length = self.length*0.8
        let angle = self.angle + Double.pi/12
        let line =  TreeLine(origin: origin, length: length, angle: angle)
        return line
    }
    
    private func animate () {
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 3 * length/250
        shape.add(animation, forKey: "lineAnimation")
    }
    
    private func makePath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: origin)
        path.addLine(to: end)
        path.close()
        return path
    }
    
}
