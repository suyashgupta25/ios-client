//
//  EnsemblesTableViewModel.swift
//  Gigsterous
//
//  Created by Michal Svacha on 12.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import Foundation
import Bond

/// ViewModel for events' table.
class EnsemblesTableViewModel {
    let ensembles = MutableObservableArray<Ensemble>([])
    
    /// Downloads the latest data, saves it and calls the optional closure.
    ///
    /// - Parameter reload: Flag indication whether current data should be overriden or appended.
    /// - Parameter success: Optional closure performed after loading has been performed.
    func refreshData(reload: Bool, success: (() -> Void)?) {
        _ = ReactiveClient().ensemblesSignal().observeNext { ensbls in
            if reload {
                self.ensembles.removeAll()
            }
            
            self.ensembles.insert(contentsOf: ensbls, at: self.ensembles.count)
            success?()
        }
    }
}
