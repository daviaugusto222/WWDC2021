//
//  PlanetsScene.swift
//  BookCore
//
//  Created by David Augusto on 13/04/21.
//

import Foundation
import SpriteKit

public class Planet {
    var node: SKShapeNode
    var lock: Bool
    var name: String
    var song: String
    
    init(node: SKShapeNode, lock: Bool, name: String, song: String) {
        self.node = node
        self.lock = lock
        self.name = name
        self.song = song
    }
}

public class PlanetsScene: SKScene {
    

    private var planets: [Planet] = []
    private var planet = ["Mercurio", "Venus", "Terra", "Marte"]
    private var positions = [CGPoint(x: 0, y: 100), CGPoint(x: 200, y: 200), CGPoint(x: -200, y: -200), CGPoint(x: 300, y: 300)]
    private var sizes = [30, 40, 60, 40]
    
    var memoryGame: MemoryGameNode!

    override public func didMove(to view: SKView) {
    
        for (index, planet) in planet.enumerated() {
            let planeta = SKShapeNode(circleOfRadius: CGFloat(sizes[index]))
            planeta.lineWidth = 0
            planeta.fillColor = .green
            planeta.position = positions[index]
            planeta.name = planet
    
            addChild(planeta)
            
            planets.append(Planet(node: planeta, lock: true, name: planet, song: "\(planet).mp3"))
        }
         
    }


    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let frontTouchNode = atPoint(location)
        
        if (frontTouchNode.name == planets[0].node.name) {
            
            if planets[0].lock == false {
                planets[0].node.fillColor = .blue
                let soundAction = SKAction.playSoundFileNamed(planets[0].song, waitForCompletion: false)
                planets[0].node.run(soundAction)
            } else {
                memoryGame = MemoryGameNode(planetsScene: self)
                addChild(memoryGame)
            }
            
            
        }
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

