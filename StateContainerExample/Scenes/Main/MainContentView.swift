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

                Button { } label: { router.newDetailViewNavigation }
                    .padding()
                    .background(Color.orange.opacity(0.8))

            }.onLoad { viewModel.viewLoaded.send() }
        }
    }
}
