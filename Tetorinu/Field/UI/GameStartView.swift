//
//  GameStartView.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/27.
//

import SwiftUI

struct GameStartView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("Tap to Start").font(.largeTitle).bold().foregroundStyle(.white)
                    }.frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.3).background(
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

#Preview {
    GameStartView()
}
