//
//  TetorinuController.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/26.
//

import SwiftUI

struct TetorinuController: View {
    
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    @Binding var tetorinuVM: TetorinuViewModel
    
    @State var blockSize: CGFloat = 10
    
    @State var valOpacity: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack{
                    Rectangle().fill(.red).overlay(content: {
                        VStack{
                            if firstLaunch {
                                Image(systemName: "arrowshape.left").font(.largeTitle).bold()
                                
                            }
                        }
                    }).onTapGesture {
                        tetorinuVM.minoControl(command: .left)
                        let selectedFeedback =  UIImpactFeedbackGenerator(style: .heavy)
                        selectedFeedback.impactOccurred()
                    }
                    
                    VStack {
                        Rectangle().fill(.yellow).overlay(content: {
                            VStack{
                                if firstLaunch {
                                    Image(systemName: "arrow.counterclockwise").font(.largeTitle).bold()
                                }
                            }
                        }).onTapGesture {
                            tetorinuVM.minoControl(command: .rotate)
                            let selectedFeedback =  UIImpactFeedbackGenerator(style: .heavy)
                            selectedFeedback.impactOccurred()
                            
                        }
                        Rectangle().fill(.green).overlay(content: {
                            VStack {
                                if firstLaunch {
                                    Image(systemName: "arrowshape.down").font(.largeTitle).bold()
                                }
                            }
                        }).onTapGesture {
                            tetorinuVM.minoControl(command: .forward)
                            let selectedFeedback =  UIImpactFeedbackGenerator(style: .heavy)
                            selectedFeedback.impactOccurred()
                        }
                    }
                    
                    Rectangle().fill(.blue).overlay(content: {
                        VStack{
                            if firstLaunch {
                                Image(systemName: "arrowshape.right").font(.largeTitle).bold()
                            }
                        }
                    }).onTapGesture {
                        tetorinuVM.minoControl(command: .right)
                        let selectedFeedback =  UIImpactFeedbackGenerator(style: .heavy)
                        selectedFeedback.impactOccurred()
                    }
                }.frame(height: geo.size.height / 3)
            }.opacity(valOpacity)
                .onAppear() {
                    
                    
                    if firstLaunch {
                        self.valOpacity = 1
                    } else {
                        self.valOpacity = 0.2
                    }
                    
                }.onChange(of: firstLaunch) {
                    withAnimation {
                        valOpacity = 0.2
                    }
                }
        }
    }
}

//#Preview {
//    TetorinuController(tetorinuVM: TetorinuViewModel.init())
//}
