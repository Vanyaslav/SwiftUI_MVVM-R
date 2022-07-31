//
//  MainContentView.swift
//  Test
//
//  Created by Tomas Baculák on 13/05/2022.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject private (set) var viewModel: MainContentViewModel
    
    init(with viewModel: MainContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                progressButton
                recentValueLabel
                progressSlider
                navigationButton
            }
            .onAppear { viewModel.viewLoaded.send() }
        }
    }
}
