//
//  MemoryGameNode.swift
//  BookCore
//
//  Created by David Augusto on 13/04/21.
//

import Foundation
import SpriteKit

class MemoryGameNode: SKNode {
    
    var planetsScene: PlanetsScene
        
    var backgroud = SKShapeNode()
    var close = SKShapeNode()
    
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
        
    init(planetsScene: PlanetsScene) {
        self.planetsScene = planetsScene
        super.init()
        setupNodes()
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes() {
        addChild(backgroud)
        addChild(close)
        
        backgroud.path = CGPath(rect:  CGRect(x: 0, y: 0, width: 1000, height: 800), transform: nil)
        backgroud.fillColor = .white
        backgroud.position = CGPoint(x: -backgroud.frame.width/2, y: -backgroud.frame.height/2)
        
        close.path = CGPath(rect:  CGRect(x: 0, y: 0, width: 50, height: 50), transform: nil)
        close.fillColor = .red
        close.name = "close"
        close.position = CGPoint(x: backgroud.frame.width/2 - 40, y: backgroud.frame.height/2 - 40)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let frontTouchNode = atPoint(location)

        if (frontTouchNode.name == close.name) {
            close.fillColor = .blue
            self.isHidden = true
            
        }
    }
}
