//
//  TetorinuField.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUI

struct TetorinuFieldView: View {
    
    @State var tetorinuVM: TetorinuViewModel = .init()
    
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    @State var blockSize: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack{
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
                                            .frame(width: blockSize, height: blockSize).border(Color.white, width: 0.2)
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
                            }
                        }.onAppear() {
                            self.width = geometry.size.height * 0.4
                            self.height = self.width * 2
                            self.blockSize = self.width / 10
                            //
                            tetorinuVM.initTetorinu()
                            tetorinuVM.initBlock()
                            tetorinuVM.drawScreen()
                            
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { Timer in
                                if tetorinuVM.isRunning {
                                    tetorinuVM.fallBlock()
                                }
                            }
                        }
                        Spacer()
                        HStack {
                            Button {
                                tetorinuVM.minoControl(command: .left)
                            } label: {
                                Circle().frame(width: width * 0.3)
                            }
                            Button {
                                tetorinuVM.minoControl(command: .rotate)
                            } label: {
                                Circle().frame(width: width * 0.3)
                            }
                            Button {
                                tetorinuVM.minoControl(command: .right)
                            } label: {
                                Circle().frame(width: width * 0.3)
                            }
                            
                        }
                    }
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("next").foregroundStyle(.white)
                            Spacer()
                        }
                        VStack(spacing: 0){
                            ForEach(0..<tetorinuVM.blockSizeMax, id: \.self) { y in
                                HStack(spacing: 0){
                                    ForEach(0..<tetorinuVM.blockSizeMax, id: \.self) { x in
                                        if tetorinuVM.downBlock.shape.getPattern()[y][x] {
                                            Rectangle()
                                                .fill(tetorinuVM.downBlock.shape.getColor())
                                                .frame(width: blockSize * 0.6, height: blockSize * 0.6).border(Color.black, width: 0.2)
                                        } else {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: blockSize * 0.6, height: blockSize * 0.6).border(Color.black, width: 0.2)
                                        }
                                    }
                                }
                            }
                        }.border(Color.white, width: 1)
                        Spacer().frame(height: height)
                    }
                }.background(Color.black)
                if !tetorinuVM.isRunning {
                    Text("Tap to start").foregroundStyle(.red).onTapGesture {
                        if !tetorinuVM.isRunning {
                            tetorinuVM.isRunning.toggle()
                        }
                    }
                }
            }.onAppear(){
                // 通知を監視する
                NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { _ in
                    tetorinuVM.isRunning = false
                    print("App will resign active (moving to background)")
                }
            }
        }
    }
}

#Preview {
    TetorinuFieldView()
}
