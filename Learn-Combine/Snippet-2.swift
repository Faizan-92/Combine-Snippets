//
//  Snippet-1.swift
//  Learn-Combine
//
//  Created by Faizan Memon on 10/12/24.
//
import Combine
import Foundation

public final class TrafficLight {
    public enum Light: String {
        case blue
        case green
        case yellow
        case red
    }

    @Published public var currentLight: Light

    public init(light: Light) {
        self.currentLight = light
    }
}

private var cancellables: Set<AnyCancellable> = []

func run2() {
    let trafficLight = TrafficLight(light: .blue)
    trafficLight.$currentLight
        .sink { newLight in
            print(newLight.rawValue)
        }
        .store(in: &cancellables)
    

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        trafficLight.currentLight = .green
        trafficLight.currentLight = .yellow
        trafficLight.currentLight = .red
    }
}
