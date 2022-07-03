//
//  DetailContentView.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import SwiftUI

struct DetailContentView: View {
    private let viewModel: DetailContentViewModel

    init(with viewModel: DetailContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.data).font(.largeTitle)
    }
}
