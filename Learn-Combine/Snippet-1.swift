//
//  Snippet-1.swift
//  Learn-Combine
//
//  Created by Faizan Memon on 10/12/24.
//
import Combine
import Foundation

func run1() {
    Just(27)
        .sink { value in
            print("Received value \(value)")
        }
    
    enum CustomError: String, Error {
        case badURL
    }
    
    [1,2,3,4,5].publisher
        .filter { $0.isMultiple(of: 2) }
        .sink { value in
            print("Received value \(value)")
        }
    
    Fail(error: CustomError.badURL)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let myError):
                print("Received failure completion \(myError)")
            case .finished:
                print("Received failure finished event")
            }
            
        }, receiveValue: { value in
            print("Received failure value \(value)")
        })
}
