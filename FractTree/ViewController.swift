//
//  ViewController.swift
//  FractTree
//
//  Created by LUIS FELIPE B PEREIRA on 21/08/23.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var currentLevel: [TreeLine] = []
    var nextLevel: [TreeLine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let root = TreeLine(origin: .init(x: view.frame.midX, y: .zero), length: 100, angle: Double.pi/2)
        currentLevel.append(root)
        drawTree()
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        currentLevel = nextLevel
        nextLevel = []
        drawTree()
    }
    
    private func drawTree() {
        var isFirstFromLevel = true
        while !currentLevel.isEmpty{
            let line = currentLevel.removeFirst()
            if isFirstFromLevel {
                line.animation.delegate = self
                isFirstFromLevel = false
            }
            line.draw(inside: view)
            let right = line.createRightLine()
            let left = line.createLeftLine()
            if right.length > 20.0 {
                nextLevel.append(right)
                nextLevel.append(left)
            }
            
        }
        
    }
    
}


