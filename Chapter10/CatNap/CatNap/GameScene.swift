//
//  GameScene.swift
//  CatNap
//
//  Created by CoderDream on 2018/12/25.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol CustomNodeEvents {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Cat:     UInt32 = 0b1    // 1
    static let Block:   UInt32 = 0b10   // 2
    static let Bed:     UInt32 = 0b100  // 4
    static let Edge:    UInt32 = 0b1000 // 8
}

// 10.7.3 检测实体之间的碰撞
class GameScene: SKScene, SKPhysicsContactDelegate {
    // 10.3 将精灵连接到变量
    var bedNode : BedNode!
    var catNode : CatNode!
    
    override func didMove(to view: SKView) {
        // 10.1 开始
        // Calculate playable margin
        let maxAspectRatio : CGFloat = 16.0 / 9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin : CGFloat = (size.height - maxAspectRatioHeight) / 2
        
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height - maxAspectRatioHeight * 2)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        
        // 10.7.3 检测实体之间的碰撞
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        
        // 10.2 定制节点类
        enumerateChildNodes(withName: "//*", using: {
            node, _ in
            if let customNode = node as? CustomNodeEvents {
                customNode.didMoveToScene()
            }
        })
        
        // 10.3 将精灵连接到变量
        // Treating a forced downcast to 'BedNode' as optional will never produce 'nil'
        bedNode = childNode(withName: "bed") as? BedNode
        catNode = childNode(withName: "//cat_body") as? CatNode
        
//        bedNode.setScale(1.5)
//        catNode.setScale(1.5)
        // 10.6 背景音乐
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgroundMusic.mp3")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Cat | PhysicsCategory.Bed {
            print("SUCCESS")
        } else if collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
            print("FAIL")
        }
    }
}
