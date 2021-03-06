//
//  BedNode.swift
//  CatNap
//
//  Created by coderdream on 2018/12/27.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import SpriteKit

class BedNode : SKSpriteNode, CustomNodeEvents {
    func didMoveToScene() {
        print("bed added to scene")
        // 10.4.3 用代码创建简单实体
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        physicsBody!.isDynamic = false
        // 10.7 控制实体
        physicsBody!.categoryBitMask = PhysicsCategory.Bed
        // 设置为None，不想让床和任何其他的游戏对象碰撞
        physicsBody!.collisionBitMask = PhysicsCategory.None
    }
}
