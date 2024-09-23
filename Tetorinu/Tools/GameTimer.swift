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
    
    var time: TimeInterval = 0
    
    var cancellable = Set<AnyCancellable>()
    let changeTimerCalled = PassthroughSubject<Void, Never>()
    
    init(time: TimeInterval) {
        self.time = time
        
        changeTimerCalled.sink { [weak self] () in
            guard let self else { return }
            self.isRunning.toggle()
        }.store(in: &cancellable)
    }
    
    func timeCheck() async throws {
        Timer(timeInterval: time, repeats: false) {_ in 
            self.changeTimerCalled.send()
        }
    }
    
}
