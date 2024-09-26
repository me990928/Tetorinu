//
//  GameOverView.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/27.
//

import SwiftUI

struct GameOverView: View {
    
    @Binding var tetorinuVM: TetorinuViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("GAME OVER").bold().foregroundStyle(.red).font(.largeTitle)
                        Text("Score: \(tetorinuVM.score)").bold().foregroundStyle(.white).font(.largeTitle)
                        Text("Best: \(tetorinuVM.bestScore)").bold().foregroundStyle(.white).font(.largeTitle)
                        Text("Tap to Restart").bold().foregroundStyle(.white).font(.largeTitle)
                    }.frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.5).background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
