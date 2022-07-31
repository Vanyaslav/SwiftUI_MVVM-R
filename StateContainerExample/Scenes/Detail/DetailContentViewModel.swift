//
//  DetailContentViewModel.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import Combine
import Foundation

class DetailContentViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    // in
    @Published var updateValue: String = ""
    @Published var confirmPressed: Void = ()
    
    let initialData: String

    init(
        data: Decimal,
        dataService: DataService,
        validateServices: ValidationService
    ) {
        self.initialData = "\(data)"

        $confirmPressed
            .dropFirst()
            .sink { [weak self] in
                guard let self = self,
                      validateServices
                    .validate(self.updateValue.decimal,
                              as: .number)
                else { return }
                dataService
                    .update(self.updateValue.decimal)
            }.store(in: &subscriptions)
    }
}
