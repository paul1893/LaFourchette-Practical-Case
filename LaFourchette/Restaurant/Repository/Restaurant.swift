import Foundation

struct Restaurant : Equatable {
    let pictureURL: String?
    let name: String
    let speciality: String
    let description: String
    let address: Address
    let cardPrice: Int
    let score: Score
    let chefName: String?
    let starters: [Meal]
    let meals: [Meal]
    let desserts: [Meal]
    let menus: [Menu]
    let tripAdvisorScore: Score
}

struct Address : Equatable {
    let street: String
    let city: String
    let zipcode: String
    let country: String
}

struct Score : Equatable {
    let avg: Float?
    let count: Int
}

struct Meal : Equatable {
    let name: String
    let price: Float?
}

struct Menu : Equatable {
    let weekTime: WeekTime
    let minPrice: Float
    let maxPrice: Float
}

enum WeekTime {
    case LUNCH_WEEK
    case LUNCH_WEEKEND
    case DINER_WEEK
    case DINER_WEEKEND
}
