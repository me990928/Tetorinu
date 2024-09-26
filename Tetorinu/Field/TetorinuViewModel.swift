//
//  TetorinuViewModel.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import Observation
import SwiftUICore
import Combine

@Observable
class TetorinuViewModel {
    let defaultField: [[Field]] = FieldTemplate.init().defaultField
    let blockSizeMax: Int = Block.init().BlockShapeNull.getSize()
    let fieldWidth: Int = 10
    let fieldHeight: Int = 20
    
    var time: Double = 1
    var timer: Timer?
    
    var score: Int = 0
    
    var isRunning: Bool = false
    
    var field: [[Field]]
    
    var outputField: [[Field]]
    
    var downBlock: DownBlock = .init()
    
    var nextDownBlock: DownBlock = .init()
    var isNextDownBlock: Bool = false
    
    var isGameOver: Bool = false
    
    init() {
        self.field = defaultField
        self.outputField = defaultField
    }
    
    func initTetorinu(){
        field = defaultField
        score = 0
        time = 1
        drawScreen()
    }
    
    func initBlock(){
        if !isNextDownBlock {
            downBlock.shape = Block.init().getRandomShape()
            
            let rotateCount: Int = Int.random(in: 0..<4)
            for _ in 0..<rotateCount{
                rotateBlock()
            }
        } else {
            downBlock = nextDownBlock
            isNextDownBlock = false
        }
        downBlock.x = fieldWidth / 2 - Block.init().BlockShapeNull.getSize() / 2
        downBlock.y = 0
    }

    
    func nextBlock(){
        nextDownBlock.shape = Block.init().getRandomShape()
        
        let rotateCount: Int = Int.random(in: 0..<4)
        for _ in 0..<rotateCount{
            nextRotateBlock()
        }
        
        isNextDownBlock = true
    }
    
    func rotateBlock(){
        var rotateBlockDownBlock: DownBlock = DownBlock()
        rotateBlockDownBlock.shape = Block.init().getShape()
        
        let size: Int = downBlock.shape.getSize()
        
        var newPattern: [[Bool]] = Block.init().BlockShapeNull.getPattern()
        
        // 90度回転
        for y in 0..<size{
            for x in 0..<size{
                newPattern[size - 1 - x][y] = downBlock.shape.getPattern()[y][x]
            }
        }
        
        rotateBlockDownBlock.shape.setPattern(newPattern)
        let dx = downBlock.x
        let dy = downBlock.y
        
        rotateBlockDownBlock.x = dx
        rotateBlockDownBlock.y = dy
        
        for y in 0..<size{
            for x in 0..<size{
                if rotateBlockDownBlock.y + y >= fieldHeight || rotateBlockDownBlock.x + x >= fieldWidth {
                    return
                }
                if rotateBlockDownBlock.shape.getPattern()[y][x] && field[rotateBlockDownBlock.y + y][rotateBlockDownBlock.x + x].type == BlockType.BlockHard.rawValue {
                    return
                }
            }
        }
        
        downBlock.shape.setPattern(newPattern)
        
    }
    
    func nextRotateBlock(){
        var rotateBlockDownBlock: DownBlock = DownBlock()
        rotateBlockDownBlock.shape = Block.init().getShape()
        
        let size: Int = nextDownBlock.shape.getSize()
        
        var newPattern: [[Bool]] = Block.init().BlockShapeNull.getPattern()
        
        // 90度回転
        for y in 0..<size{
            for x in 0..<size{
                newPattern[size - 1 - x][y] = nextDownBlock.shape.getPattern()[y][x]
            }
        }
        
        nextDownBlock.shape.setPattern(newPattern)
        
    }
    
    func fallBlock(){
        
        let lastBlock: DownBlock = DownBlock(block: downBlock)
        downBlock.y += 1
        
        if blockIntersectField {
            downBlock = DownBlock(block: lastBlock)
            for y in 0..<blockSizeMax{
                for x in 0..<blockSizeMax{
                    if downBlock.shape.getPattern()[y][x] {
                        field[downBlock.y + y][downBlock.x + x].type = BlockType.BlockSoft.rawValue
                        field[downBlock.y + y][downBlock.x + x].color = downBlock.shape.getColor()
                    }
                }
            }
            eraseLine()
            initBlock()
            nextBlock()
        }
        
        if blockIntersectField {
            // game over
//            initTetorinu()
            isGameOver = true
            isRunning = false
        }
        
        drawScreen()
    }
    
    func eraseLine(){
        for y in 0..<fieldHeight {
            var completeLine: Bool = true
            
            // yの列が揃ったか確認
            for x in 0..<fieldWidth{
                if field[y][x].type == BlockType.BlockNone.rawValue {
                    completeLine = false
                    break
                }
            }
            
            // 揃ったら
            if completeLine {
                
                // y列を消す
                for x in 0..<fieldWidth{
                    if field[y][x].type == BlockType.BlockSoft.rawValue {
                        field[y][x].type = BlockType.BlockNone.rawValue
                        score += 1
                    }
                }
                
                
                for x in 0..<fieldWidth{
                    for y2 in stride(from: y, through: 0, by: -1) {
                        if field[y2][x].type == BlockType.BlockHard.rawValue {
                            break
                        }
                        
                        if y2 == 0 {
                            field[y2][x].type = BlockType.BlockNone.rawValue
                            field[y2][x].color = .clear
                        } else {
                            if (field[y2 - 1][x].type != BlockType.BlockHard.rawValue) {
                                field[y2][x] = field[y2 - 1][x]
                            }
                        }
                    }
                }
            }
        }
        score += 3
    }
    
    var blockIntersectField: Bool{
        for y in 0..<downBlock.shape.getSize() {
            for x in 0..<downBlock.shape.getSize() {
                if downBlock.shape.getPattern()[y][x] {
                    
                    let globalX: Int = downBlock.x + x
                    let globalY: Int = downBlock.y + y
                    
                    if (globalX < 0) || (globalX >= fieldWidth) || (globalY < 0) || (globalY >= fieldHeight) || (field[globalY][globalX].type != BlockType.BlockNone.rawValue) {
                        return true
                    }
                    
                }
            }
        }
        return false
    }
    
    func drawScreen(){
        var screen: [[Field]] = field
        
        for y in 0..<blockSizeMax{
            for x in 0..<blockSizeMax{
                if downBlock.shape.getPattern()[y][x] {
                    screen[downBlock.y + y][downBlock.x + x].type = BlockType.BlockFall.rawValue
                    screen[downBlock.y + y][downBlock.x + x].color = downBlock.shape.getColor()
                }
            }
        }
        outputField = screen
    }
   
    func minoControl(command: Command){
        
        if isRunning == false {
            return
        }
        
        let lastBlock = downBlock
        
        switch command {
        case .left:
            downBlock.x -= 1
        case .right:
            downBlock.x += 1
        case .forward:
            downBlock.y += 1
        case .rotate:
            rotateBlock()
        }
        
        if blockIntersectField {
            downBlock = lastBlock
        } else {
            drawScreen()
        }
    }
    
    func tetorinuTimer(){
        
        let minus: Double = 0.01
        
        // 初期値の確認
        if time == 1 {
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true) { [self] Timer in
                if !self.isGameOver {
                    if self.isRunning {
                        fallBlock()
                    }
                }
            }
            return
        }
        
        if (time - minus) > 0 {
            time -= minus
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true) { [self] Timer in
                if !self.isGameOver {
                    if self.isRunning {
                        fallBlock()
                    }
                }
            }
            return
        }
        
    }
}

enum Command: String {
    case left = "a"
    case right = "d"
    case forward = "w"
    case rotate = "s"
}
