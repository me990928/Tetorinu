//
//  Block Shape.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import SwiftUICore

struct BlockShape {
    private let size: Int
    private var pattern: [[Bool]]
    private let color: Color
    
    init(size: Int, pattern: [[Bool]], color: Color) {
        self.size = size
        self.pattern = pattern
        self.color = color
    }
    
    public func getSize() -> Int {
        size
    }
    
    public func getPattern() -> [[Bool]] {
        pattern
    }
    
    public mutating func setPattern(_ pattern: [[Bool]]) {
        self.pattern = pattern
    }
}
