//
//  PlanetsScene.swift
//  BookCore
//
//  Created by David Augusto on 13/04/21.
//

import Foundation
import SpriteKit

public class Planet {
    var node: SKSpriteNode
    var lock: Bool
    var name: String
    var song: String
    
    init(node: SKSpriteNode, lock: Bool, name: String, song: String) {
        self.node = node
        self.lock = lock
        self.name = name
        self.song = song
    }
}

public class PlanetsScene: SKScene {
    
    private var planets: [Planet] = []
    private var planet = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    private var positions = [CGPoint(x: 10, y: 200),
                             CGPoint(x: 250, y: 50),
                             CGPoint(x: -60, y: -260),
                             CGPoint(x: -250, y: -60),
                             CGPoint(x: 350, y: -250),
                             CGPoint(x: -350, y: 250),
                             CGPoint(x: 450, y: 280),
                             CGPoint(x: -350, y: -350)]
    
    private var sizes = [CGSize(width: 100, height: 100),
                         CGSize(width: 140, height: 140),
                         CGSize(width: 160, height: 160),
                         CGSize(width: 120, height: 120),
                         CGSize(width: 250, height: 250),
                         CGSize(width: 220, height: 220),
                         CGSize(width: 180, height: 180),
                         CGSize(width: 150, height: 150),
                        ]
    private var sun: SKSpriteNode!
    
    private var background: SKSpriteNode!
    
    var namesGame: NamesGameNode!

    override public func didMove(to view: SKView) {
        
        let fontURL = Bundle.main.url(forResource: "Ribeye-Regular", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
       
       
        background = SKSpriteNode()
        background.texture = SKTexture(imageNamed: "background")
//        background.zPosition = -1
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        
        sun = SKSpriteNode()
        sun.texture = SKTexture(imageNamed: "Sun")
        sun.size = CGSize(width: 300, height: 300)
        sun.position = CGPoint(x: 0, y: 0)
        sun.name = "Sun"

        addChild(sun)
        
        
        for (index, planet) in planet.enumerated() {
            let planeta = SKSpriteNode()
            planeta.texture = SKTexture(imageNamed: "planetLock")
            planeta.size = sizes[index]
            planeta.position = positions[index]
            planeta.name = planet
    
            addChild(planeta)
            
            planets.append(Planet(node: planeta, lock: true, name: planet, song: "\(planet).m4a"))
        }
        
        
        
        
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let frontTouchNode = atPoint(location)
        
        //Se tocar no Sol
        if frontTouchNode.name == sun.name {
            let soundAction = SKAction.group([
                SKAction.playSoundFileNamed("Sun.m4a", waitForCompletion: false),
                SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed: "SunSing")),
                                   SKAction.wait(forDuration: 4),
                                   SKAction.setTexture(SKTexture(imageNamed: "Sun")),]),
                SKAction.customAction(withDuration: 0, actionBlock: { (_, _) in
                    for planety in self.planets {
                        if !planety.lock {
                            let soundAction = SKAction.sequence([
                                SKAction.playSoundFileNamed(planety.song, waitForCompletion: false),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                                SKAction.wait(forDuration: 1),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)")),
                                SKAction.wait(forDuration: 1),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                                SKAction.wait(forDuration: 1),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)")),
                                SKAction.wait(forDuration: 1),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                                SKAction.wait(forDuration: 1),
                                SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)"))
                                
                            ])
                                
                            planety.node.run(soundAction)
                            
                        }
                    }
                })
            ])
                
            sun.run(soundAction)
        }
        
        //Se tocar no planeta
        for planety in planets {
            if frontTouchNode.name == planety.node.name {
                
                if planety.lock == false {
                    let soundAction = SKAction.sequence([
                        SKAction.playSoundFileNamed(planety.song, waitForCompletion: false),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                        SKAction.wait(forDuration: 1),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)")),
                        SKAction.wait(forDuration: 1),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                        SKAction.wait(forDuration: 1),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)")),
                        SKAction.wait(forDuration: 1),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)Sing")),
                        SKAction.wait(forDuration: 1),
                        SKAction.setTexture(SKTexture(imageNamed: "\(planety.name)"))
                        
                    ])
                    
                    planety.node.run(soundAction)
                } else {
                    namesGame = NamesGameNode(planetsScene: self, planet: planety)
                    namesGame.delegate = self
                    namesGame.setScale(0)
                    
                    
                    addChild(namesGame)
                    
                    let repeatAction = SKAction.sequence([SKAction.unhide(),  SKAction.scale(to: 1, duration: 0.4) ])
                    namesGame.run(repeatAction)
                }
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

extension PlanetsScene: PlanetDelegate {
    func completePlanet(planet: Planet) {
        for item in planets {
            if item.name == planet.name {
                item.lock = false
//                item.node.texture = SKTexture(imageNamed: planet.name)
                let point = item.node.position
                let size = item.node.size
                let action = SKAction.sequence([SKAction.wait(forDuration: 2),
                                                SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 0.5),
                                                SKAction.scale(to: 3, duration: 0.7),
                                                SKAction.setTexture(SKTexture(imageNamed: item.name)),
                                                SKAction.wait(forDuration: 1),
                                                SKAction.move(to: point, duration: 0.5),
                                                SKAction.scale(to: size, duration: 0.3) ])
                item.node.run(action)
                
            }
        }
    }
}
