//
//  ContentView.swift
//  Learn-Combine
//
//  Created by Faizan Memon on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            run4()
        }
    }
}

#Preview {
    ContentView()
}
