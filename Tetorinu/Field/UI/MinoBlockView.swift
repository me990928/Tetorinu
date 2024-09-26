//
//  MinoBlockView.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/27.
//

import SwiftUI

struct MinoBlockView: View {
    
    let blockSize: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: blockSize, height: blockSize).border(color == .black ? Color.white : Color.black, width: 0.3)
    }
}
