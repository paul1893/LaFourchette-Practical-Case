import XCTest
@testable import LaFourchette

class RestaurantInteractorTests: XCTestCase {
    private let restaurant = Restaurant(
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
        chefName: "Rémi",
        starters: [Meal](),
        meals: [Meal(name: "Ratatouille", price: 10)],
        desserts: [Meal](),
        menus: [Menu](),
        tripAdvisorScore: Score(avg: 9.9, count: 1000)
    )

    class MockRemoteRepository : RemoteRestaurantRepository {
        var restaurant: Restaurant? = nil
        var loadRestaurantFunction = false
        
        private let error : RepositoryError?
        
        init(error: RepositoryError? = nil) {
            self.error = error
        }
        
        func getRestaurant() -> Promise<Restaurant, RepositoryError> {
            loadRestaurantFunction = true
            if let error = error {
                return Promise(.failure(error))
            }
            return Promise(.success(restaurant!))
        }
    }
    class MockPresenter : RestaurantPresenter {
        var presentFunction = false
        var presentFunctionValue: Restaurant? = nil
        var presentErrorFunction = false
        
        func present(with restaurant: Restaurant) {
            presentFunction = true
            presentFunctionValue = restaurant
        }
        
        func presentError() {
            presentErrorFunction = true
        }
    }
    
    func testLoadRestaurant() {
        // GIVEN
        let remoteRepository = MockRemoteRepository()
        remoteRepository.restaurant = restaurant
        let presenter = MockPresenter()
        let interactor = RestaurantInteractorImpl(
            remoteRepository: remoteRepository,
            presenter: presenter
        )
        
        // WHEN
        interactor.loadRestaurant()
        
        // THEN
        XCTAssertTrue(remoteRepository.loadRestaurantFunction)
        XCTAssertTrue(presenter.presentFunction)
        XCTAssertEqual(presenter.presentFunctionValue, restaurant)
    }
    
    func testLoadRestaurant_WhenRepositoryThrowError() {
        // GIVEN
        let mockRemoteRepository = MockRemoteRepository(error: RepositoryError.serverError)
        let mockPresenter = MockPresenter()
        let interactor = RestaurantInteractorImpl(
            remoteRepository: mockRemoteRepository,
            presenter: mockPresenter
        )
        
        // WHEN
        interactor.loadRestaurant()
        
        // THEN
        XCTAssertTrue(mockPresenter.presentErrorFunction)
    }

}
