//
//  TetorinuField.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUI

struct TetorinuField: View {
    
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    @State var blockSize: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                Spacer()
                ForEach(0..<20) { y in
                    HStack(spacing: 0){
                        Spacer()
                        ForEach(0..<10) { x in
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: blockSize, height: blockSize).border(Color.black, width: 0.2)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }.onAppear() {
                self.width = geometry.size.width * 0.8
                self.height = self.width * 2
                self.blockSize = self.width / 10
            }
        }
    }
}

#Preview {
    TetorinuField()
}
