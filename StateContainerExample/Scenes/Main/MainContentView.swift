//
//  MainContentView.swift
//  Test
//
//  Created by Tomas Baculák on 13/05/2022.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject private var viewModel: MainContentViewModel
    private let router: AppRouter
    
    init(with viewModel: MainContentViewModel,
         router: AppRouter) {
        self.viewModel = viewModel
        self.router = router
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                progressButton
                recentValueLabel
                progressSlider
                navigationButton
            }.onLoad { viewModel.viewLoaded.send() }
        }
    }
}

extension MainContentView {
    var progressButton: some View {
        Button { viewModel.makeProgressPressed.send() } label: { Text("Progress !!!") }
            .padding()
            .background(Color.black.opacity(0.8))
    }

    var recentValueLabel: some View {
        Text("Recent value: \(viewModel.outputValue)")
    }

    var progressSlider: some View {
        Slider(value: Binding<Double>(
            get: { viewModel.outputValue },
            set: { viewModel.manualProgress = $0 }),
               in: 0...MainContentViewModel.maxValue,
               step: 0.01)
        .padding()
    }

    var navigationButton: some View {
        Button { } label: { router.newDetailViewNavigation }
            .padding()
            .background(Color.orange.opacity(0.8))
    }
}
