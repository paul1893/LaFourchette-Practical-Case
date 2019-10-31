import Foundation

protocol Parser{
    associatedtype T
    func parse(_ data: Data) -> Promise<RestaurantJSON, RepositoryError>
}

class RestaurantParser : Parser {
    typealias T = RestaurantJSON
    func parse(_ data: Data) -> Promise<RestaurantJSON, RepositoryError> {
        do {
            let data = try JSONDecoder().decode(DataJSON.self, from: data).data
            return Promise(.success(data))
        } catch {
            return Promise(.failure(RepositoryError.parsingError))
        }
    }
}

struct DataJSON : Codable {
    let data: RestaurantJSON
}

struct RestaurantJSON : Codable {
    let name: String
    let address: String
    let city: String
    let zipcode: String
    let country: String
    let pics_main: [String : String]
    let rate_count: Int
    let avg_rate: Float?
    let card_price: Int
    let speciality: String
    let chef_name: String?
    let description: String
    let card_start_1: String?
    let card_start_2: String?
    let card_start_3: String?
    let card_main_1: String?
    let card_main_2: String?
    let card_main_3: String?
    let card_dessert_1: String?
    let card_dessert_2: String?
    let card_dessert_3: String?
    let price_card_start_1: Float?
    let price_card_start_2: Float?
    let price_card_start_3: Float?
    let price_card_main_1: Float?
    let price_card_main_2: Float?
    let price_card_main_3: Float?
    let price_card_dessert_1: Float?
    let price_card_dessert_2: Float?
    let price_card_dessert_3: Float?
    let menus: MenusJSON?
    let trip_advisor_avg_rating: Float
    let trip_advisor_review_count: Int
}

struct MenusJSON : Codable {
    let menus_lunch_week: MenuJSON?
    let menus_lunch_weekend: MenuJSON?
    let menus_diner_week: MenuJSON?
    let menus_diner_weekend: MenuJSON?
}

struct MenuJSON : Codable {
    let min_price: Float
    let max_price: Float
}
