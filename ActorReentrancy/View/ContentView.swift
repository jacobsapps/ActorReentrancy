//
//  ContentView.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Friends") {
                    ForEach(viewModel.friends, id: \.id) {
                        Text($0.name)
                    }
                }
            }
            .refreshable {
                await viewModel.load()
            }
            .task {
                await viewModel.load()
            }
            .navigationTitle("Hello \(viewModel.user?.name ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
