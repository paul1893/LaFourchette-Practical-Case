import Foundation
protocol RemoteRestaurantRepository {
    func getRestaurant() -> Promise<Restaurant, RepositoryError>
}

final class RemoteRestaurantRepositoryImpl : RemoteRestaurantRepository {
    private let DEFAULT_SIZE_PICTURE = "664x374"
    private let caller: Caller
    private let parser: RestaurantParser
    private var api: String
    
    init(_ api: String, _ caller: Caller = CallerImpl(), _ parser: RestaurantParser = RestaurantParser()) {
        self.caller = caller
        self.parser = parser
        self.api = api
    }
    
    func getRestaurant() -> Promise<Restaurant, RepositoryError> {
        if let url = URL(string: api) {
            let (receivedData, error) = caller.get(with: url)
            guard error == nil else { return Promise(.failure(RepositoryError.serverError)) }
            guard let data = receivedData else { return Promise(.failure(RepositoryError.serverError)) }
            
            return parser.parse(data)
                .then {
                    let restaurant = self.transform($0)
                    return Promise(.success(restaurant))
            } ?? Promise<Restaurant, RepositoryError>(.failure(RepositoryError.parsingError))
        }
        return Promise(.failure(RepositoryError.wrongUrl))
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
        return [
            (restaurantJson.card_start_1, restaurantJson.price_card_start_1),
            (restaurantJson.card_start_2, restaurantJson.price_card_start_2),
            (restaurantJson.card_start_3, restaurantJson.price_card_start_3)
            ]
            .filter({ $0.0 != nil })
            .map({ Meal(name: $0.0!, price: $0.1) })
    }
    
    private func collectMeals(from restaurantJson: RestaurantJSON) -> [Meal] {
        return [
            (restaurantJson.card_main_1, restaurantJson.price_card_main_1),
            (restaurantJson.card_main_2, restaurantJson.price_card_main_2),
            (restaurantJson.card_main_3, restaurantJson.price_card_main_3)
            ]
            .filter({ $0.0 != nil })
            .map({ Meal(name: $0.0!, price: $0.1) })
    }
    
    private func collectDesserts(from restaurantJson: RestaurantJSON) -> [Meal] {
        return [
            (restaurantJson.card_dessert_1, restaurantJson.price_card_dessert_1),
            (restaurantJson.card_dessert_2, restaurantJson.price_card_dessert_2),
            (restaurantJson.card_dessert_3, restaurantJson.price_card_dessert_3)
            ]
            .filter({ $0.0 != nil })
            .map({ Meal(name: $0.0!, price: $0.1) })
    }
    
    private func collectMenus(from restaurantJson: RestaurantJSON) -> [Menu] {
        return [
            (WeekTime.LUNCH_WEEK, restaurantJson.menus?.menus_lunch_week),
            (WeekTime.LUNCH_WEEKEND, restaurantJson.menus?.menus_lunch_weekend),
            (WeekTime.DINER_WEEK, restaurantJson.menus?.menus_diner_week),
            (WeekTime.DINER_WEEKEND, restaurantJson.menus?.menus_diner_weekend)
            ]
            .filter({ $0.1 != nil })
            .map({ Menu(weekTime: $0.0, minPrice: $0.1!.min_price, maxPrice: $0.1!.max_price) })
    }
}

enum RepositoryError: Error {
    case serverError
    case parsingError
    case wrongUrl
}

