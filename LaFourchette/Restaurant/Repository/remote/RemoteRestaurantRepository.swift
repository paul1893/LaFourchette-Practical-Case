import Foundation

protocol RemoteRestaurantRepository {
    func getRestaurant() throws -> Restaurant
}

class RemoteRestaurantRepositoryImpl : RemoteRestaurantRepository {
    private let DEFAULT_SIZE_PICTURE = "664x374"
    private let caller: Caller
    private let parser: RestaurantParser
    private var api: String
    
    init(_ api: String, _ caller: Caller = CallerImpl(), _ parser: RestaurantParser = RestaurantParser()) {
        self.caller = caller
        self.parser = parser
        self.api = api
    }
    
    func getRestaurant() throws -> Restaurant  {
        if let url = URL(string: api) {
            let (receivedData, error) = caller.get(with: url)
            guard error == nil else { throw RepositoryError.serverError }
            guard let data = receivedData else { throw RepositoryError.serverError }
            
            let restaurantJson = try parser.parse(data)
            return transform(restaurantJson)
        }
        throw RepositoryError.wrongUrl
    }
    
    private func transform(_ restaurantJson: RestaurantJSON) -> Restaurant {
        let restaurant = Restaurant(
            pictureURL: restaurantJson.pics_main[DEFAULT_SIZE_PICTURE],
            name: restaurantJson.name,
            speciality: restaurantJson.speciality,
            description: restaurantJson.description,
            address: Address(
                street: restaurantJson.address,
                city: restaurantJson.city,
                zipcode: restaurantJson.zipcode,
                country: restaurantJson.country
            ),
            cardPrice: restaurantJson.card_price,
            score: Score(
                avg: restaurantJson.avg_rate,
                count: restaurantJson.rate_count
            ),
            chefName: restaurantJson.chef_name,
            starters: collectStarters(from: restaurantJson),
            meals: collectMeals(from: restaurantJson),
            desserts: collectDesserts(from: restaurantJson),
            menus: collectMenus(from: restaurantJson),
            tripAdvisorScore: Score(
                avg: restaurantJson.trip_advisor_avg_rating,
                count: restaurantJson.trip_advisor_review_count
            )
        )
        
        return restaurant
    }
    
    private func collectStarters(from restaurantJson: RestaurantJSON) -> [Meal] {
        var starters = [Meal]()
        if let starter1 = restaurantJson.card_start_1 {
            starters.append(
                Meal(name: starter1, price: restaurantJson.price_card_start_1)
            )
        }
        if let starter2 = restaurantJson.card_start_2 {
            starters.append(
                Meal(name: starter2, price: restaurantJson.price_card_start_2)
            )
        }
        if let starter3 = restaurantJson.card_start_3 {
            starters.append(
                Meal(name: starter3, price: restaurantJson.price_card_start_3)
            )
        }
        return starters
    }
    
    private func collectMeals(from restaurantJson: RestaurantJSON) -> [Meal] {
        var meals = [Meal]()
        if let meal1 = restaurantJson.card_main_1 {
            meals.append(
                Meal(name: meal1, price: restaurantJson.price_card_main_1)
            )
        }
        if let meal2 = restaurantJson.card_main_2 {
            meals.append(
                Meal(name: meal2, price: restaurantJson.price_card_main_2)
            )
        }
        if let meal3 = restaurantJson.card_main_3 {
            meals.append(
                Meal(name: meal3, price: restaurantJson.price_card_main_3)
            )
        }
        return meals
    }
    
    private func collectDesserts(from restaurantJson: RestaurantJSON) -> [Meal] {
        var desserts = [Meal]()
        if let dessert1 = restaurantJson.card_dessert_1 {
            desserts.append(
                Meal(name: dessert1, price: restaurantJson.price_card_dessert_1)
            )
        }
        if let dessert2 = restaurantJson.card_dessert_2 {
            desserts.append(
                Meal(name: dessert2, price: restaurantJson.price_card_dessert_2)
            )
        }
        if let dessert3 = restaurantJson.card_dessert_3 {
            desserts.append(
                Meal(name: dessert3, price: restaurantJson.price_card_dessert_3)
            )
        }
        return desserts
    }
    
    private func collectMenus(from restaurantJson: RestaurantJSON) -> [Menu] {
        var menus = [Menu]()
        if let menuLunchWeek = restaurantJson.menus?.menus_lunch_week {
            menus.append(
                Menu(weekTime: WeekTime.LUNCH_WEEK, minPrice: menuLunchWeek.min_price, maxPrice: menuLunchWeek.max_price)
            )
        }
        if let menuLunchWeekend = restaurantJson.menus?.menus_lunch_weekend {
            menus.append(
                Menu(weekTime: WeekTime.LUNCH_WEEKEND, minPrice: menuLunchWeekend.min_price, maxPrice: menuLunchWeekend.max_price)
            )
        }
        if let menuDinerWeek = restaurantJson.menus?.menus_diner_week {
            menus.append(
                Menu(weekTime: WeekTime.DINER_WEEK, minPrice: menuDinerWeek.min_price, maxPrice: menuDinerWeek.max_price)
            )
        }
        if let menuDinerWeekend = restaurantJson.menus?.menus_diner_weekend {
            menus.append(
                Menu(weekTime: WeekTime.DINER_WEEKEND, minPrice: menuDinerWeekend.min_price, maxPrice: menuDinerWeekend.max_price)
            )
        }
        return menus
    }
}

enum RepositoryError: Error {
    case serverError
    case parsingError
    case wrongUrl
}

