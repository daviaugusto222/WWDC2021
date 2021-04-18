//
//  IntroductionScene.swift
//  BookCore
//
//  Created by David Augusto on 17/04/21.
//

import Foundation
import SpriteKit


public class IntroductionScene: SKScene {
    
    

    private var astronault: SKSpriteNode!
    private var background: SKSpriteNode!
    
  

    override public func didMove(to view: SKView) {
        
      
        background = SKSpriteNode()
        background.texture = SKTexture(imageNamed: "backgroundIntro")
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        astronault = SKSpriteNode()
        astronault.texture = SKTexture(imageNamed: "Astronault")
        astronault.size = CGSize(width: 602.98, height: 700)
        astronault.position = CGPoint(x: self.frame.midX - 190, y: self.frame.midY)
        let action = SKAction.repeatForever( SKAction.sequence([SKAction.moveTo(y: 40, duration: 3),
                                        SKAction.moveTo(y: -40, duration: 3)
        ]))
        astronault.run(action)
        
        addChild(astronault)
        

 
        
    }
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override public func update(_ currentTime: TimeInterval) {
    }
}
