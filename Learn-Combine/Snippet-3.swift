//
//  Snippet-1.swift
//  Learn-Combine
//
//  Created by Faizan Memon on 10/12/24.
//
import Combine
import Foundation

public enum LiveScoreError: Error, LocalizedError {
    case badWeather
    
    public var errorDescription: String? {
        switch self {
        case .badWeather:
            return "The game was suspended due to bad waeather conditions"
        }
    }
}

private var cancellables = Set<AnyCancellable>()
func run3() {
    let passThroughSubject = PassthroughSubject<String, LiveScoreError>()
    let liveScore = LiveScore(publisher: passThroughSubject)
    liveScore.publisher
        .sink(receiveCompletion: { completionResult in
            switch completionResult {
            case .finished:
                print("Match ended!")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { announcement in
            print(announcement)
        })
        .store(in: &cancellables)

    liveScore.sendAnnouncement("Match Started")
    liveScore.sendAnnouncement("Goal Recorded 15'")
    liveScore.sendAnnouncement("Half Time")
    liveScore.matchSuspended(withReason: .badWeather)
    liveScore.matchEnded()
}

public struct LiveScore<T: Subject> where T.Failure == LiveScoreError {
    
    public var publisher: T
    
    public init(publisher: T) {
        self.publisher = publisher
    }
    
    public func sendAnnouncement(_ announcement: T.Output) {
        publisher.send(announcement)
    }
    
    public func matchEnded() {
        publisher.send(completion: .finished)
    }
    
    public func matchSuspended(withReason reason: LiveScoreError) {
        publisher.send(completion: .failure(reason))
    }
}

func run4() {
    let currentValueSubject = CurrentValueSubject<String, LiveScoreError>("Match started!")
    let liveScore = LiveScore(publisher: currentValueSubject)
    liveScore.publisher
        .sink { completionResult in
            switch completionResult {
            case .finished:
                print("Match ended!")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { announcement in
            print(announcement)
        }
        .store(in: &cancellables)

    liveScore.sendAnnouncement("Goal Recorded 29'")
    print("Latest value is \(liveScore.publisher.value)")
    liveScore.sendAnnouncement("Half Time")
    liveScore.matchSuspended(withReason: .badWeather)
    liveScore.matchEnded()
    print("Latest value is \(liveScore.publisher.value)")
}
