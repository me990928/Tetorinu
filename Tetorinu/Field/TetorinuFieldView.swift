//
//  TetorinuField.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUI

struct TetorinuFieldView: View {
    
    @State var tetorinuVM: TetorinuViewModel = .init()
    @State var timer = GameTimer()
    
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    @State var blockSize: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0){
                    Spacer()
                    ForEach(0..<tetorinuVM.fieldHeight, id: \.self) { y in
                        HStack(spacing: 0){
                            Spacer()
                            ForEach(0..<tetorinuVM.fieldWidth, id: \.self) { x in
                                
                                if tetorinuVM.outputField[y][x].type == BlockType.BlockHard.rawValue {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                                }
                                
                                if tetorinuVM.outputField[y][x].type == BlockType.BlockNone.rawValue {
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                                }
                                
                                if tetorinuVM.outputField[y][x].type == BlockType.BlockFall.rawValue {
                                    Rectangle()
                                        .fill(tetorinuVM.outputField[y][x].color)
                                        .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                                }
                                
                                if tetorinuVM.outputField[y][x].type == BlockType.BlockSoft.rawValue {
                                    Rectangle()
                                        .fill(tetorinuVM.outputField[y][x].color)
                                        .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                                }
                            }
                            Spacer()
                        }.onTapGesture {
                            tetorinuVM.rotateBlock()
                            tetorinuVM.drawScreen()
                        }
                    }.onAppear() {
                        self.width = geometry.size.width * 0.8
                        self.height = self.width * 2
                        self.blockSize = self.width / 10
                        //
                        tetorinuVM.initTetorinu()
                        tetorinuVM.initBlock()
                        tetorinuVM.drawScreen()
                        
                    } label: {
                        Circle().frame(width: width * 0.3)
                    }
                    Button {
                        tetorinuVM.downBlock.x += 1
                    } label: {
                        Circle().frame(width: width * 0.3)
                    }

                }
            }
        }
    }
}

#Preview {
    TetorinuFieldView()
}
