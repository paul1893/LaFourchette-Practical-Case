import XCTest
@testable import LaFourchette

class RestaurantPresenterTests: XCTestCase {
    class MockView : RestaurantView {
        var showErrorFunction = false
        var showErrorFunctionValue: String? = nil
        var showRestaurantFunction = false
        var showRestaurantFunctionValue: RestaurantViewModel? = nil
        
        func showError(message: String) {
            showErrorFunction = true
            showErrorFunctionValue = message
        }
        
        func showRestaurant(with restaurant: RestaurantViewModel) {
            showRestaurantFunction = true
            showRestaurantFunctionValue = restaurant
        }
    }
    
    func testPresentRestaurant() {
        // GIVEN
        let view = MockView()
        let presenter = RestaurantPresenterImpl(view: view, executor: MockExecutor())
        
        // WHEN
        presenter.present(with: Restaurant(
            pictureURL: "http://google.fr/",
            name: "Chez Gusto",
            speciality: "Français",
            description: "Le célèbre restaurant du film d'animation Pixar \"Ratatouille\"",
            address: Address(
                street: "10 rue de la paix",
                city: "Paris",
                zipcode: "75000",
                country: "FRANCE"
            ),
            cardPrice: 100,
            score: Score(
                avg: 9.5,
                count: 200000
            ),
            chefName: "Remi",
            starters: [Meal(name: "Ratatouille froide", price: 10)],
            meals: [Meal(name: "Ratatouille", price: 10)],
            desserts: [Meal(name: "Ratatouille sucrée", price: 10)],
            menus: [
                Menu(weekTime: .LUNCH_WEEK, minPrice: 0, maxPrice: 1),
                Menu(weekTime: .LUNCH_WEEKEND, minPrice: 2, maxPrice: 3),
                Menu(weekTime: .DINER_WEEK, minPrice: 4, maxPrice: 5),
                Menu(weekTime: .DINER_WEEKEND, minPrice: 6, maxPrice: 7)
            ],
            tripAdvisorScore: Score(avg: 9.9, count: 1000)
        ))
        
        // THEN
        XCTAssertTrue(view.showRestaurantFunction)
        XCTAssertEqual(view.showRestaurantFunctionValue, RestaurantViewModel(
            pictureURL: "http://google.fr/",
            title: "Chez Gusto",
            subtitle: "Français",
            priceLabel: "Prix moyen 100€",
            scoreLabel: "9.5",
            opinionLabel: "200000 avis",
            description: "Le célèbre restaurant du film d'animation Pixar \"Ratatouille\"",
            menuChefOriginLabel: "Extrait de la carte du Chef Remi",
            starters: [
                MealViewModel(name: "Ratatouille froide", price: "10 €")
            ],
            meals: [
                MealViewModel(name: "Ratatouille", price: "10 €")
            ],
            desserts: [
                MealViewModel(name: "Ratatouille sucrée", price: "10 €")
            ],
            menus: [
                MenuViewModel(name: "Seulement le midi", price: "1 €"),
                MenuViewModel(name: "Seulement le midi (weekend)", price: "3 €"),
                MenuViewModel(name: "Seulement le soir", price: "5 €"),
                MenuViewModel(name: "Seulement le soir (weekend)", price: "7 €")
            ],
            tripAdvisorScore: "9.9/10",
            tripAdvisorCount: "1000 avis"
            )
        )
    }
    
    func testPresentRestaurant_WhenNoScoreNoPictureURL() {
        // GIVEN
        let view = MockView()
        let presenter = RestaurantPresenterImpl(view: view, executor: MockExecutor())
        
        // WHEN
        presenter.present(with: Restaurant(
            pictureURL: nil,
            name: "Chez Gusto",
            speciality: "Français",
            description: "Le célèbre restaurant du film d'animation Pixar \"Ratatouille\"",
            address: Address(
                street: "10 rue de la paix",
                city: "Paris",
                zipcode: "75000",
                country: "FRANCE"
            ),
            cardPrice: 100,
            score: Score(
                avg: nil,
                count: 200000
            ),
            chefName: "Remi",
            starters: [Meal(name: "Ratatouille froide", price: 10)],
            meals: [Meal(name: "Ratatouille", price: 10)],
            desserts: [Meal(name: "Ratatouille sucrée", price: 10)],
            menus: [
                Menu(weekTime: .LUNCH_WEEK, minPrice: 0, maxPrice: 1),
                Menu(weekTime: .LUNCH_WEEKEND, minPrice: 2, maxPrice: 3),
                Menu(weekTime: .DINER_WEEK, minPrice: 4, maxPrice: 5),
                Menu(weekTime: .DINER_WEEKEND, minPrice: 6, maxPrice: 7)
            ],
            tripAdvisorScore: Score(avg: nil, count: 1000)
        ))
        
        // THEN
        XCTAssertTrue(view.showRestaurantFunction)
        XCTAssertEqual(view.showRestaurantFunctionValue, RestaurantViewModel(
            pictureURL: nil,
            title: "Chez Gusto",
            subtitle: "Français",
            priceLabel: "Prix moyen 100€",
            scoreLabel: "NC",
            opinionLabel: "200000 avis",
            description: "Le célèbre restaurant du film d'animation Pixar \"Ratatouille\"",
            menuChefOriginLabel: "Extrait de la carte du Chef Remi",
            starters: [
                MealViewModel(name: "Ratatouille froide", price: "10 €")
            ],
            meals: [
                MealViewModel(name: "Ratatouille", price: "10 €")
            ],
            desserts: [
                MealViewModel(name: "Ratatouille sucrée", price: "10 €")
            ],
            menus: [
                MenuViewModel(name: "Seulement le midi", price: "1 €"),
                MenuViewModel(name: "Seulement le midi (weekend)", price: "3 €"),
                MenuViewModel(name: "Seulement le soir", price: "5 €"),
                MenuViewModel(name: "Seulement le soir (weekend)", price: "7 €")
            ],
            tripAdvisorScore: "NC",
            tripAdvisorCount: "1000 avis"
            )
        )
    }
    
    func testPresentError() {
        // GIVEN
        let view = MockView()
        let presenter = RestaurantPresenterImpl(view: view, executor: MockExecutor())
        
        // WHEN
        presenter.presentError()
        
        // THEN
        XCTAssertTrue(view.showErrorFunction)
    }
}
