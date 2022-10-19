//
//  Collection + extensions.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation

extension Collection {

    /// returns index at the specified index if it is within index otherwise nil
    subscript(safeIndex index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
