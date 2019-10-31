import XCTest
@testable import LaFourchette

class RestaurantParserTests: XCTestCase {
    
    func testParser_WhenDataIsWrong() {
        // GIVEN
        let parser = RestaurantParser()
        
        // WHEN
        parser.parse(Data())
            .then {_ in 
                XCTFail()
            }.catch {
                // THEN
                XCTAssertTrue(true)
            }
    }
}
