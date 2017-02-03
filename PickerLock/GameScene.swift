//
//  GameScene.swift
//  PickerLock
//
//  Created by saurabh deopura on 12/12/16.
//  Copyright © 2016 Deopura. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var   Circle = SKSpriteNode()
    var   Person = SKSpriteNode()
    
    var   Dot = SKSpriteNode()
    
    
    var Path = UIBezierPath()
    
    var gameStarted = Bool()
    
    var movingClockWise = Bool()
    
    var intersected = false
    
    
    
    
    override func didMove(to view: SKView) {
        Circle = SKSpriteNode (imageNamed:"Circle")
        Circle.size = CGSize(width: 300, height: 300)
        Circle.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(Circle)
        
        Person = SKSpriteNode(imageNamed: "Person")
        Person.size = CGSize(width: 40, height: 7)
        Person.position=CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2 + 122)
        Person.zRotation = 3.14 / 2
        Person.zPosition = 2.0
        self.addChild(Person)
        AddDot()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if gameStarted == false
        {
            
            moveClockWise()
            movingClockWise = true
            gameStarted = true
            
        }
            
        else if gameStarted == true
        {
            
            if movingClockWise == true
            {
                moveCounterClockwise()
                movingClockWise = false
                
            }
            else if movingClockWise == false
            {
                moveClockWise()
                movingClockWise = true
            }
            
            
        }
        
        
        
    }
    
    func AddDot(){
        
        Dot = SKSpriteNode(imageNamed: "Dot")
        Dot.size = CGSize(width: 30, height: 30)
        Dot.zPosition = 2.0
        
        let dx = Person.position.x - self.frame.midX / 2
        let dy = Person.position.y - self.frame.midY / 2
        
        let rad = atan2(dy, dx)
        
        if movingClockWise == true{
            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4), clockwise: true)
            Dot.position = Path2.currentPoint
            
        }
        else if movingClockWise == false{
            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4), clockwise: true)
            Dot.position = Path2.currentPoint
            
            
        }
        self.addChild(Dot)
        
        
    }
    
    
    
    
    
    
    
    func moveClockWise()
    {
        let dx = Person.position.x - self.frame.midX / 2
        let dy = Person.position.y - self.frame.midY / 2
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2),radius: 122, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        
        let follow = SKAction.follow(Path.cgPath, asOffset:false, orientToPath: true, speed: 200)
        Person.run(SKAction.repeatForever(follow).reversed())
    }
    
    
    func moveCounterClockwise()
    {
        
        let dx = Person.position.x - self.frame.midX / 2
        let dy = Person.position.y - self.frame.midY / 2
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2),radius: 122, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        
        let follow = SKAction.follow(Path.cgPath, asOffset:false, orientToPath: true, speed: 200)
        Person.run(SKAction.repeatForever(follow))
        
        
    }
    
    
    override func update (_ currentTime: CFTimeInterval)
    {
        if Person.intersects(Dot)
        {
            intersected = true
            
        }
            
        else
        {
            if intersected == true
            {
                if Person.intersects(Dot) == false
                {
                    self.removeAllChildren()
                    let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
                    let action2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.2)
                    self.scene?.run(SKAction.sequence([action1,action2]))
                    //movingClockWise = false
                    // intersected = false
                    
                    
                }
            }
        }
    }
    
    
}
