//
//  NamesGameNode.swift
//  BookCore
//
//  Created by David Augusto on 13/04/21.
//

import Foundation
import SpriteKit
import AVFoundation

protocol PlanetDelegate {
    func completePlanet(planet: Planet)
}

class NamesGameNode: SKNode {
    
    var planetsScene: PlanetsScene
        
    var backgroud = SKSpriteNode()
    var close = SKSpriteNode()
    var card = SKSpriteNode()
    var letter = SKLabelNode()
    var planet: Planet!
    
    var labelSpeak = SKLabelNode()
    
    var nodeCards: [SKNode] = []
    var nodeLetters: [SKNode] = []
    private var currentNode: SKNode?
    
    var delegate: PlanetDelegate?
    
    let synthesizer = AVSpeechSynthesizer()
    
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
        
    init(planetsScene: PlanetsScene, planet: Planet) {
        self.planetsScene = planetsScene
        self.planet = planet
        super.init()
        setupNodes()
        setupCards(word: planet.name)
        setupLetters(word: planet.name)
        
        
        synthesizer.delegate = self
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func setupNodes() {
        addChild(backgroud)
        addChild(close)
        
        backgroud.texture = SKTexture(imageNamed: "backgroundGame")
        backgroud.size = CGSize(width: planetsScene.frame.width / 1.2, height: planetsScene.frame.height / 1.5)
        backgroud.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        close.texture = SKTexture(imageNamed: "close")
        close.size = CGSize(width: 30, height: 30)
        close.name = "close"
        close.position = CGPoint(x: backgroud.frame.width/2 - 40, y: backgroud.frame.height/2 - 40)
    }
    
    func setupCards(word: String) {
        
        let letters = word.map { String($0) }
        var position = 0
        for lett in letters {
            let cardy = SKSpriteNode()
            let lettery = SKLabelNode()
            
            cardy.texture = SKTexture(imageNamed: "card")
            cardy.size = CGSize(width: backgroud.frame.width/CGFloat(letters.count + 2), height: backgroud.frame.height/4)
            cardy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            cardy.position = CGPoint(x: Int(backgroud.frame.minX) + 20 + (Int(cardy.frame.width) / 2) + position, y: Int(backgroud.frame.minY) + 120)
    //        card.zRotation = 0.7871; // About 90 degrees
            cardy.name = "\(lett)Card"
            cardy.color = .lightGray
            cardy.colorBlendFactor = 0.4
            
            
            lettery.fontSize = cardy.frame.height/2
            lettery.fontColor = .black
            lettery.fontName = "Ribeye-Regular"
            lettery.text = lett
            lettery.verticalAlignmentMode = .center
            lettery.horizontalAlignmentMode = .center
    //        letter.zRotation = card.zRotation
            lettery.position = CGPoint(x: 0, y: 0)
            
            let spacing = backgroud.frame.width - (cardy.frame.width * CGFloat(letters.count))
            position += (Int(spacing) / letters.count) + Int(cardy.frame.width)
            cardy.addChild(lettery)
            addChild(cardy)
            nodeCards.append(cardy)
            
        }
    }
    
    func setupLetters(word: String) {
        
        var letters = word.map { String($0) }
        letters.shuffle()
        var position = 0
        var randomX = 0
        var randomY = 0
        var angle = 0.0
        for lett in letters {
            let cardy = SKSpriteNode()
            let lettery = SKLabelNode()
            randomX = Int.random(in: 0..<100)
            randomY = Int.random(in: 50..<300)
            angle = Double.random(in: -0.6..<0.6)
            
            cardy.texture = SKTexture(imageNamed: "card")
            cardy.size = CGSize(width: backgroud.frame.width/CGFloat(letters.count + 4), height: backgroud.frame.height/5)
            cardy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            cardy.position = CGPoint(x: Int(backgroud.frame.minX) + randomX + (Int(cardy.frame.width) / 2) + position, y: Int(backgroud.frame.maxY) - 120 - randomY)
            cardy.zRotation = CGFloat(angle)
            cardy.name = lett
            cardy.color = .yellow
            cardy.colorBlendFactor = 0.4
            cardy.run(SKAction.sequence([
                SKAction.rotate(byAngle: 0.3, duration: 0.4),
                SKAction.rotate(byAngle: -0.3, duration: 0.4)
                ]))
            
            
            lettery.fontSize = cardy.frame.height/2
            lettery.fontColor = .black
            lettery.verticalAlignmentMode = .center
            lettery.horizontalAlignmentMode = .center
            lettery.fontName = "Ribeye-Regular"
            lettery.text = lett
//            lettery.zRotation = cardy.zRotation
            lettery.position = CGPoint(x: 0, y: 0)
            
            
            let spacing = backgroud.frame.width - (cardy.frame.width * CGFloat(letters.count))
            position += (Int(spacing) / letters.count) + Int(cardy.frame.width)
            cardy.addChild(lettery)
            addChild(cardy)
            
            nodeLetters.append(cardy)
           
        }
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let frontTouchNode = atPoint(location)

        if (frontTouchNode.name == close.name) {
            self.isHidden = true
            
        }
        
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                
                for letter in nodeLetters {
                    if node.name == letter.name{

                        let repeatAction = SKAction.sequence([ SKAction.group(
                            [SKAction.scale(to: 1.2, duration: 0.3),
                             SKAction.rotate(byAngle: -node.zRotation, duration: 0.3)
                             ]
                        ),
                        SKAction.repeatForever(
                        SKAction.sequence([
                            SKAction.rotate(byAngle: 0.2, duration: 0.2),
                            SKAction.rotate(byAngle: -0.2, duration: 0.2)
                            ])
                        )
                        ])
                        node.run(repeatAction)
                        self.currentNode = node
                    }
                }
                
                
            }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
            let repeatAction = SKAction.sequence(
                [SKAction.scale(to: 1.3, duration: 0.3)
                 ]
            )
            node.run(repeatAction)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let current = self.currentNode else { return }
        current.removeAllActions()
        
        for node in nodeCards {
            guard let nodeName = node.name else {
                print("sem nome")
                return
            }
            guard let currentName = current.name else {
                print("current sem nome")
                return
            }
            
            if node.contains(current.position) && nodeName.starts(with: currentName) {
                guard let nod = node as? SKSpriteNode else { return }
                let repeatAction = SKAction.sequence([SKAction.scale(to: 0, duration: 0.2), SKAction.hide()])
                current.run(repeatAction)
                
                nodeLetters.removeAll { value in
                    return value == current
                }
                
                let actionNod = SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1), SKAction.scale(to: 1, duration: 0.2), SKAction.colorize(with: .green, colorBlendFactor: 0.4, duration: 0.3)])
                nod.run(actionNod)
                
                labelSpeak.text = current.name
                guard let name = labelSpeak.text?.lowercased() else { return }
                let utterance = AVSpeechUtterance(string: name)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")


                synthesizer.speak(utterance)
                   
                
                
                
            } else {
                let repeatAction = SKAction.sequence([SKAction.scale(to: 1, duration: 0.3),
                                                      SKAction.moveTo(y: 50, duration: 0.3)])
                current.run(repeatAction)
            }
        }
        
        if nodeLetters.isEmpty {
            close.isHidden = true
            //Animaçoes de finalização aqui
            let actionbackground = SKAction.sequence([SKAction.scaleY(to: 0.5, duration: 0.7)])
            backgroud.run(actionbackground)
            
            for card in nodeCards {
                let action = SKAction.sequence([SKAction.moveTo(y: self.frame.midY, duration: 0.7)])
                card.run(action)
            }
            
            let repeatAction = SKAction.sequence([SKAction.wait(forDuration: 1),
                                                  SKAction.customAction(withDuration: 0, actionBlock: {_,_ in
                                                    
                                                    self.labelSpeak.text = self.planet.name
                                                    
                                                    let utterance = AVSpeechUtterance(string: self.planet.name.lowercased())
                                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                                    
                                                    self.synthesizer.speak(utterance)
                                                    
                                                  }),
                                                  SKAction.wait(forDuration: 1),
                                                  SKAction.scale(to: 0, duration: 0.2)])
            self.run(repeatAction)
            
            delegate?.completePlanet(planet: planet)
        }

        self.currentNode = nil
    }
    
}

extension NamesGameNode: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        labelSpeak.attributedText = mutableAttributedString
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        labelSpeak.attributedText = NSAttributedString(string: utterance.speechString)
    }
}
