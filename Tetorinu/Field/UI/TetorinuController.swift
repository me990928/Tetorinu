//
//  TetorinuController.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/26.
//

import SwiftUI

struct TetorinuController: View {
    
    @State var tetorinuVM: TetorinuViewModel
    
    @State var blockSize: CGFloat = 10
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack{
                    Rectangle().fill(.red).onTapGesture {
                        tetorinuVM.minoControl(command: .left)
                    }
                    
                    VStack {
                        Rectangle().fill(.yellow).onTapGesture {
                            tetorinuVM.minoControl(command: .rotate)
                        }
                        Rectangle().fill(.green).onTapGesture {
                            tetorinuVM.minoControl(command: .forward)
                        }
                    }
                    
                    Rectangle().fill(.blue).onTapGesture {
                        tetorinuVM.minoControl(command: .right)
                    }
                }.frame(height: geo.size.height / 3)
            }.opacity(0.12)
        }
    }
}

#Preview {
    TetorinuController(tetorinuVM: TetorinuViewModel.init())
}
