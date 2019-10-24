import XCTest
@testable import LaFourchette

class RestaurantControllerTests: XCTestCase {

    class MockInteractor : RestaurantInteractor {
        var loadRestaurantFunction = false
        
        func loadRestaurant() {
            loadRestaurantFunction = true
        }
    }

    func testViewDidLoad() {
        // GIVEN
        let interactor = MockInteractor()
        let controller = RestaurantController(with: interactor, executor: MockExecutor())
        
        // WHEN
        controller.viewDidLoad()
        
        // THEN
        XCTAssertTrue(interactor.loadRestaurantFunction)
    }
}
