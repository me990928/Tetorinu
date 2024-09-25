//
//  Block.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUICore

struct Block {
    let BlockShapeI: BlockShape = .init(size: 3, pattern: [
        [false, true, false],
        [false, true, false],
        [false, true, false]
    ], color: Color.cyan)
    
    let BlockShapeJ: BlockShape = .init(size: 3, pattern: [
        [false, true, false],
        [false, true, false],
        [true, true, false]
    ], color: Color.blue)
    
    let BlockShapeL: BlockShape = .init(size: 3, pattern: [
        [false, true, false],
        [false, true, false],
        [false, true, true]
    ], color: Color.orange)
    
    let BlockShapeO: BlockShape = .init(size: 3, pattern: [
        [false, true, true],
        [false, true, true],
        [false, false, false]
    ], color: Color.yellow)
    
    let BlockShapeS: BlockShape = .init(size: 3, pattern: [
        [false, false, true],
        [false, true, true],
        [false, true, false]
    ], color: Color.red)
    
    let BlockShapeS2: BlockShape = .init(size: 3, pattern: [
        [false, true, false],
        [false, true, true],
        [false, false, true]
    ], color: Color.green)
    
    let BlockShapeT: BlockShape = .init(size: 3, pattern: [
        [false, true, false],
        [false, true, true],
        [false, true, false]
    ], color: Color.purple)
    
    let BlockShapeNull: BlockShape = .init(size: 3, pattern: [
        [false, false, false],
        [false, false, false],
        [false, false, false],
    ], color: Color.clear)
    
    let BlockShapeMax: Int = 7
    
    var shape: BlockShape
    
    
    init(shape: BlockShape, num: Int) {
        self.shape = shape
    }
    
    init () {
        self.shape = BlockShapeNull
    }
    
    func getShape() -> BlockShape {
        return shape
    }
    
    func getRandomShape() -> BlockShape {
        var shpe: BlockShape
        
        switch Int.random(in: 0..<BlockShapeMax) {
        case 0:
            shpe = BlockShapeI
        case 1:
            shpe = BlockShapeJ
        case 2:
            shpe = BlockShapeL
        case 3:
            shpe = BlockShapeO
        case 4:
            shpe = BlockShapeS
        case 5:
            shpe = BlockShapeS2
        case 6:
            shpe = BlockShapeT
        default:
            shpe = BlockShapeI
        }
        
        return shpe
    }
}
