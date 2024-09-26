//
//  DeviceOrientation.swift
//  Tetorinu
//
//  Created by 広瀬友哉 on 2024/09/26.
//
import Combine
import UIKit

class DeviceOrientation: ObservableObject {
    @Published var orientation: UIDeviceOrientation
    
    private var cancellables: AnyCancellable?
    
    init() {
        self.orientation = UIDevice.current.orientation
        
        cancellables = NotificationCenter
            .default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink{ _ in
                self.orientation = UIDevice.current.orientation
            }
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        cancellables?.cancel()
    }
}
