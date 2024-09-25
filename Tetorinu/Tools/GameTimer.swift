//
//  GameTimer.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/23.
//

import Foundation
import Combine

class GameTimer: ObservableObject {
    
    var isRunning: Bool = false
    
    var time: Double = 1
    
    var cancellable = Set<AnyCancellable>()
    let changeTimerCalled = PassthroughSubject<Void, Never>()
    
    init() {
    }

    func startTimer() async {
        while isRunning {
            sleep(UInt32(time))
            print("hi")
            
        }
    }
    
}
