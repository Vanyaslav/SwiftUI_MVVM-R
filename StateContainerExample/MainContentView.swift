//
//  MainContentView.swift
//  Test
//
//  Created by Tomas Baculák on 13/05/2022.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject private var viewModel: MainContentViewModel
    
    init(with viewModel: MainContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button { viewModel.buttonPressed.send() } label: { Text("Progress !!!") }
                .frame(width: 150, height: 40, alignment: .center)
                .background(Color.black.opacity(0.8))

            Text("Recent value: \(viewModel.outputValue)")

            Slider(value: Binding<Double>(
                get: { viewModel.outputValue },
                set: { viewModel.manualProgress = $0 }),
                   in: 0...MainContentViewModel.maxValue)

        }.onAppear { viewModel.viewLoaded.send() }
    }
}
