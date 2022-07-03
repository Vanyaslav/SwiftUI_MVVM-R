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
        NavigationView {
            VStack {
                Button { viewModel.makeProgressPressed.send() } label: { Text("Progress !!!") }
                    .padding()
                    .background(Color.black.opacity(0.8))

                Text("Recent value: \(viewModel.outputValue)")

                Slider(value: Binding<Double>(
                    get: { viewModel.outputValue },
                    set: { viewModel.manualProgress = $0 }),
                       in: 0...MainContentViewModel.maxValue)
                .padding()

                Button { viewModel.showDetailPressed = () } label: { Text("Show detail !!!") }
                    .padding()
                    .background(Color.orange.opacity(0.8))
                // navigation linx
                viewModel.router.detailViewNavigation

            }.onAppear { viewModel.viewLoaded.send() }
        }
    }
}
