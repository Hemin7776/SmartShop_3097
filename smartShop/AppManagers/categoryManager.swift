

import Foundation
import SwiftUI

struct CategoryOption : Identifiable{
    let id = UUID()
    let name : String
    let icon : String
    let color : Color
}


class CategoryManager {
    static let shared = CategoryManager()
    
    let predefinedCategories: [CategoryOption] = [
        CategoryOption(name: "Food", icon: "fork.knife", color: .orange.opacity(0.5)),
        CategoryOption(name: "Cleaning", icon: "hands.and.sparkles.fill", color: .cyan.opacity(0.5)),
        CategoryOption(name: "Grocery", icon: "basket.fill", color: .mint.opacity(0.5)),
        CategoryOption(name: "Medication", icon: "pills.fill", color: .green.opacity(0.5)),
        CategoryOption(name: "Electronics", icon: "desktopcomputer", color: .blue.opacity(0.5)),
        CategoryOption(name: "Clothing", icon: "tshirt.fill", color: .pink.opacity(0.5)),
        CategoryOption(name: "Home", icon: "house.fill", color: .brown.opacity(0.5)),
        CategoryOption(name: "Books", icon: "book.fill", color: .purple.opacity(0.5)),
        CategoryOption(name: "Sports", icon: "sportscourt.fill", color: .red.opacity(0.5)),
        CategoryOption(name: "Beauty", icon: "drop.fill", color: .indigo.opacity(0.5))
    ]
    
    func colorToString(_ color: Color) -> String {
        if color == .orange.opacity(0.5) { return "orange" }
        else if color == .cyan.opacity(0.5) { return "cyan" }
        else if color == .mint.opacity(0.5) { return "mint" }
        else if color == .green.opacity(0.5) { return "green" }
        else if color == .blue.opacity(0.5) { return "blue" }
        else if color == .pink.opacity(0.5) { return "pink" }
        else if color == .brown.opacity(0.5) { return "brown" }
        else if color == .purple.opacity(0.5) { return "purple" }
        else if color == .red.opacity(0.5) { return "red" }
        else if color == .indigo.opacity(0.5) { return "indigo" }
        else { return "gray" }
    }
    
    func stringToColor(_ string: String) -> Color {
        switch string {
        case "orange": return .orange.opacity(0.5)
        case "cyan": return .cyan.opacity(0.5)
        case "mint": return .mint.opacity(0.5)
        case "green": return .green.opacity(0.5)
        case "blue": return .blue.opacity(0.5)
        case "pink": return .pink.opacity(0.5)
        case "brown": return .brown.opacity(0.5)
        case "purple": return .purple.opacity(0.5)
        case "red": return .red.opacity(0.5)
        case "indigo": return .indigo.opacity(0.5)
        default: return .gray.opacity(0.5)
        }
    }
}
