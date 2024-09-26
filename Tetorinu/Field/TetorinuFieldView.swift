//
//  TetorinuField.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUI
import UIKit

struct TetorinuFieldView: View {
    
    @State var tetorinuVM: TetorinuViewModel = .init()
    @StateObject var deviceOrientation: DeviceOrientation = DeviceOrientation()
    
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    @State var blockSize: CGFloat = 10
    
    @State var timer: Timer?
    
    @State private var lastUpdate: Date = Date()
    @State private var updateInterval: TimeInterval = 0.1 // 0.5秒ごとに発火
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Spacer()
                    HStack(spacing: 0){
                        Spacer()
                        VStack(spacing: 0){
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
                                                .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2).onTapGesture {
                                                    tetorinuVM.minoControl(command: .rotate)
                                                }
                                        }
                                        
                                        if tetorinuVM.outputField[y][x].type == BlockType.BlockSoft.rawValue {
                                            Rectangle()
                                                .fill(tetorinuVM.outputField[y][x].color)
                                                .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                                        }
                                    }
                                    Spacer()
                                }
                            }.onAppear() {
                                
                                UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                                
                                if deviceOrientation.orientation.isPortrait {
                                    self.width = geometry.size.height * 0.4
                                    self.height = self.width * 2
                                    self.blockSize = self.width / 10
                                } else {
                                    self.width = geometry.size.height * 0.4
                                    self.height = self.width * 2
                                    self.blockSize = self.width / 10
                                }
                                
                                // セットアップ
                                tetorinuVM.initTetorinu()
                                tetorinuVM.initBlock()
                                tetorinuVM.nextBlock()
                                tetorinuVM.drawScreen()
                                tetorinuVM.tetorinuTimer()
                            }
                            .onChange(of: deviceOrientation.orientation.isPortrait) { oldValue, newValue in
                                
                                self.width = geometry.size.height * 0.4
                                self.height = self.width * 2
                                self.blockSize = self.width / 10
                            }
                        }.frame(width: width)
                        VStack(spacing: 0){
                            
                            
                            Circle().fill(.blue).overlay {
                                Image(systemName: tetorinuVM.isRunning ? "pause.fill" : "play.fill").foregroundStyle(.white)
                            }.frame(width: width * 0.2).padding(.bottom, 20)
                                .onTapGesture {
                                    tetorinuVM.isRunning.toggle()
                                }
                            
                            
                            HStack{
                                Spacer()
                                Text("next").foregroundStyle(.white)
                                Spacer()
                            }
                            VStack(spacing: 0){
                                ForEach(0..<tetorinuVM.blockSizeMax, id: \.self) { y in
                                    HStack(spacing: 0){
                                        ForEach(0..<tetorinuVM.blockSizeMax, id: \.self) { x in
                                            if tetorinuVM.nextDownBlock.shape.getPattern()[y][x] {
                                                Rectangle()
                                                    .fill(tetorinuVM.nextDownBlock.shape.getColor())
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
                            VStack{
                                Text("Score").foregroundStyle(.white)
                                Text(tetorinuVM.score.description).foregroundStyle(.white).font(.caption)
                            }.padding(.top, 20)
                            Spacer()
                        }.frame(width: width * 0.3)
                        Spacer()
                    }
                    Spacer()
                }.background(Color.black)
                
                if tetorinuVM.isGameOver {
                    VStack{
                        Text("GAME OVER").bold().foregroundStyle(.red).font(.title)
                        Text("Tap to Restart").bold().foregroundStyle(.red).font(.title)
                    }.frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.5).background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 30, style: .continuous)
                    ).onTapGesture {
                        tetorinuVM.isGameOver.toggle()
                        
                        tetorinuVM.initTetorinu()
                        tetorinuVM.initBlock()
                        tetorinuVM.nextBlock()
                        tetorinuVM.drawScreen()
                    }
                }
                if !tetorinuVM.isRunning && !tetorinuVM.isGameOver {
                    VStack{
                        Text("Tap to Start").font(.title).foregroundStyle(.red)
                    }.frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.3).background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 30, style: .continuous)
                    ).onTapGesture {
                        tetorinuVM.isRunning.toggle()
                    }
                }
            }
            TetorinuController(tetorinuVM: tetorinuVM)
        }.onAppear(){
            // 通知を監視する
            NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { _ in
                tetorinuVM.isRunning = false
                print("App will resign active (moving to background)")
            }
            
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
        }.onDisappear(){
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
    }
}

#Preview {
    TetorinuFieldView()
}
