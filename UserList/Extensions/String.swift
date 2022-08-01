//
//  String.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

extension String {
    
    private func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
