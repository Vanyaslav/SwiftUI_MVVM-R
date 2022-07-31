//
//  DetailContentView.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import SwiftUI
import Combine

struct DetailContentView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: DetailContentViewModel

    init(with viewModel: DetailContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 70) {
                Text(viewModel.initialData)
                    .font(.largeTitle)
                Text("Enter new value within 0..1 range")
                TextEditor(text: $viewModel.updateValue).font(.title)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.gray)
                    ).padding()
                Spacer()
                Button {
                    viewModel.confirmPressed = ()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Confirm")
                }
            }
        }
    }
}
