struct RestaurantViewModel : Equatable {
    let pictureURL: String?
    let title: String
    let subtitle: String
    let priceLabel: String
    let scoreLabel: String
    let opinionLabel: String
    let description: String
    let menuChefOriginLabel: String?
    let starters: [MealViewModel]
    let meals: [MealViewModel]
    let desserts: [MealViewModel]
    let menus: [MenuViewModel]
    let tripAdvisorScore: String
    let tripAdvisorCount: String
}

struct MealViewModel : Equatable {
    let name: String
    let price: String
}

struct MenuViewModel : Equatable {
    let name: String
    let price: String
}
