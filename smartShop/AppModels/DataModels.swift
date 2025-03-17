

import Foundation
import SwiftData

@Model
final class Category {
    var name: String
    var icon: String
    var color: String
    var isSelected: Bool
    
    init(name: String, icon: String, color: String, isSelected: Bool = false) {
        self.name = name
        self.icon = icon
        self.color = color
        self.isSelected = isSelected
    }
}
