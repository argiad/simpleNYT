//
//  DependencyObject.swift
//  nyt-mvvm-dip
//
//  Created by Artem Mkrtchyan on 3/26/21.
//

import Dip


/// Centralized place for dependency management
struct DependencyObject {
    /// Shared variable for dependency registration
    static let shared = DependencyObject()

    /// Dip Container. It is exposed because target level customization is required.
    let container = DependencyContainer() { container in
        unowned let container = container
        container.register{ MvvmApi() as ApiClient}
        container.register{ api in ViewModel(apiManager: api) as ViewModel }
    }
}
