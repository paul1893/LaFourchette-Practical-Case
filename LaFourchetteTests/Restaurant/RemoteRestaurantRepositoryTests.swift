import XCTest
@testable import LaFourchette

class RemoteRestaurantRepositoryTests: XCTestCase {
    private let api = "http://api.lafourchette.com/"
    class MockCaller : Caller {
        var data: Data? = Data()
        var error: Error? = nil
        
        func get(with url: URL) -> (Data?, Error?) {
            return (data, error)
        }
    }
    
    class MockParser : RestaurantParser {
        private let error: RepositoryError?
        var json: RestaurantJSON!
        
        init(error: RepositoryError? = nil) {
            self.error = error
        }
        
        override func parse(_ data: Data) -> Promise<RestaurantJSON, RepositoryError> {
            if let error = error {
                return Promise(.failure(error))
            }
            return Promise(.success(json))
        }
    }
    
    func testGetRestaurant_WhenNoMealNoMenuNoPicture() {
        // GIVEN
        let mockCaller = MockCaller()
        let mockParser = MockParser()
        mockParser.json = RestaurantJSON(
                name: "Chez Gusto",
                address: "10 rue de la paix",
                city: "Paris",
                zipcode: "75000",
                country: "France",
                pics_main: [String : String](),
                rate_count: 200000,
                avg_rate: nil,
                card_price: 100,
                speciality: "Française",
                chef_name: nil,
                description: "Le célèbre restaurant du film Pixar \"Ratatouille\"",
                card_start_1: nil,
                card_start_2: nil,
                card_start_3: nil,
                card_main_1: nil,
                card_main_2: nil,
                card_main_3: nil,
                card_dessert_1: nil,
                card_dessert_2: nil,
                card_dessert_3: nil,
                price_card_start_1: nil,
                price_card_start_2: nil,
                price_card_start_3: nil,
                price_card_main_1: nil,
                price_card_main_2: nil,
                price_card_main_3: nil,
                price_card_dessert_1: nil,
                price_card_dessert_2: nil,
                price_card_dessert_3: nil,
                menus: nil,
                trip_advisor_avg_rating: 9.8,
                trip_advisor_review_count: 10000
        )
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl(api, mockCaller, mockParser)
        
        let promise = repository.getRestaurant()
            .then {
                // THEN
                XCTAssertEqual(
                    $0,
                    Restaurant(
                        pictureURL: nil,
                        name: "Chez Gusto",
                        speciality: "Française",
                        description: "Le célèbre restaurant du film Pixar \"Ratatouille\"",
                        address: Address(street: "10 rue de la paix", city: "Paris", zipcode: "75000", country: "France"),
                        cardPrice: 100,
                        score: Score(avg: nil, count: 200000),
                        chefName: nil,
                        starters: [Meal](),
                        meals: [Meal](),
                        desserts: [Meal](),
                        menus: [Menu](),
                        tripAdvisorScore: Score(avg: 9.8, count: 10000)
                    )
                )
            }.catch  {
                XCTFail()
            }
    }
    
    func testGetRestaurant_WhenNominalCase() {
        // GIVEN
        let mockCaller = MockCaller()
        let mockParser = MockParser()
        mockParser.json = RestaurantJSON(
                name: "Chez Gusto",
                address: "10 rue de la paix",
                city: "Paris",
                zipcode: "75000",
                country: "France",
                pics_main: ["664x374":"http://www.google.fr"],
                rate_count: 200000,
                avg_rate: 9.9,
                card_price: 100,
                speciality: "Française",
                chef_name: "Rémi",
                description: "Le célèbre restaurant du film Pixar \"Ratatouille\"",
                card_start_1: "Ratatouille froide entrée 1",
                card_start_2: "Ratatouille froide entrée 2",
                card_start_3: "Ratatouille froide entrée 3",
                card_main_1: "Ratatouille plat 1",
                card_main_2: "Ratatouille plat 2",
                card_main_3: "Ratatouille plat 3",
                card_dessert_1: "Ratatouille sucrée dessert 1",
                card_dessert_2: "Ratatouille sucrée dessert 2",
                card_dessert_3: "Ratatouille sucrée dessert 3",
                price_card_start_1: 1,
                price_card_start_2: 2,
                price_card_start_3: 3,
                price_card_main_1: 4,
                price_card_main_2: 5,
                price_card_main_3: 6,
                price_card_dessert_1: 7,
                price_card_dessert_2: 8,
                price_card_dessert_3: 9,
                menus: MenusJSON(
                    menus_lunch_week: MenuJSON(min_price: 0, max_price: 1),
                    menus_lunch_weekend: MenuJSON(min_price: 2, max_price: 3),
                    menus_diner_week: MenuJSON(min_price: 4, max_price: 5),
                    menus_diner_weekend: MenuJSON(min_price: 6, max_price: 7)
                ),
                trip_advisor_avg_rating: 9.8,
                trip_advisor_review_count: 10000
        )
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl(api, mockCaller, mockParser)
        
        let promise = repository.getRestaurant()
            .then {
                // THEN
                XCTAssertEqual(
                    $0,
                    Restaurant(
                        pictureURL: "http://www.google.fr",
                        name: "Chez Gusto",
                        speciality: "Française",
                        description: "Le célèbre restaurant du film Pixar \"Ratatouille\"",
                        address: Address(street: "10 rue de la paix", city: "Paris", zipcode: "75000", country: "France"),
                        cardPrice: 100,
                        score: Score(avg: 9.9, count: 200000),
                        chefName: "Rémi",
                        starters: [
                            Meal(name: "Ratatouille froide entrée 1", price: 1),
                            Meal(name: "Ratatouille froide entrée 2", price: 2),
                            Meal(name: "Ratatouille froide entrée 3", price: 3)
                        ],
                        meals: [
                            Meal(name: "Ratatouille plat 1", price: 4),
                            Meal(name: "Ratatouille plat 2", price: 5),
                            Meal(name: "Ratatouille plat 3", price: 6)
                        ],
                        desserts: [
                            Meal(name: "Ratatouille sucrée dessert 1", price: 7),
                            Meal(name: "Ratatouille sucrée dessert 2", price: 8),
                            Meal(name: "Ratatouille sucrée dessert 3", price: 9)
                        ],
                        menus: [
                            Menu(weekTime: WeekTime.LUNCH_WEEK, minPrice: 0, maxPrice: 1),
                            Menu(weekTime: WeekTime.LUNCH_WEEKEND, minPrice: 2, maxPrice: 3),
                            Menu(weekTime: WeekTime.DINER_WEEK, minPrice: 4, maxPrice: 5),
                            Menu(weekTime: WeekTime.DINER_WEEKEND, minPrice: 6, maxPrice: 7)
                        ],
                        tripAdvisorScore: Score(avg: 9.8, count: 10000)
                    )
                )
            }.catch  {
                XCTFail()
            }
    }
    
    func testGetRestaurant_WhenApiError_BecauseBadFormat() {
        // GIVEN
        let mockCaller = MockCaller()
        let mockParser = MockParser()
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl("hello world", mockCaller, mockParser)
        
        repository.getRestaurant()
            .then {_ in
                XCTFail()
            }.catch {
                // THEN
                XCTAssertTrue(true)
            }
    }
    
    func testGetRestaurant_WhenServerError_BecauseErrorNotNil() {
        // GIVEN
        let mockCaller = MockCaller()
        mockCaller.error = RepositoryError.serverError
        let mockParser = MockParser()
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl(api, mockCaller, mockParser)
        
        repository.getRestaurant()
            .then {_ in
                XCTFail()
            }.catch {
                // THEN
                XCTAssertTrue(true)
            }
    }
    
    func testGetRestaurant_WhenServerError_BecauseDataIsNil() {
        // GIVEN
        let mockCaller = MockCaller()
        mockCaller.data = nil
        let mockParser = MockParser()
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl(api, mockCaller, mockParser)
        
        repository.getRestaurant()
            .then {_ in
                XCTFail()
            }.catch {
                // THEN
                XCTAssertTrue(true)
            }
    }
    
    func testGetRestaurant_WhenParserError() {
        // GIVEN
        let mockCaller = MockCaller()
        let mockParser = MockParser(error: RepositoryError.parsingError)
        
        // WHEN
        let repository = RemoteRestaurantRepositoryImpl(api, mockCaller, mockParser)
        
        repository.getRestaurant()
            .then {_ in
                XCTFail()
            }.catch {
                // THEN
                XCTAssertTrue(true)
            }
    }
}
