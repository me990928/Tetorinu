//
//  DownBlock.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUI

struct DownBlock {
    var x: Int
    var y: Int
    var shape: BlockShape
    
    
//    init(x: Int, y: Int, shape: BlockShape) {
//        self.x = x
//        self.y = y
//        self.shape = shape
//    }
    
    init(){
        self.x = 0
        self.y = 0
        self.shape = Block.init().BlockShapeNull
    }
    
    init (block: DownBlock) {
        self.x = block.x
        self.y = block.y
        self.shape = block.shape
    }
}
