//
//  MainContentView+Views.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import SwiftUI

extension MainContentView {
    var progressButton: some View {
        Button { viewModel.progressPressed.send() } label: { Text("Progress !!!") }
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
        Button { } label: { viewModel.navigateToNextView(title: "Show detail !!!") }
            .padding()
            .background(Color.orange.opacity(0.8))
    }
}
