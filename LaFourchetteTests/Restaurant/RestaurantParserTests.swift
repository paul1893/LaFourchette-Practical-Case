import XCTest
@testable import LaFourchette

class RestaurantParserTests: XCTestCase {
    
    func testParser_WhenDataIsWrong() {
        // GIVEN
        let parser = RestaurantParser()
        
        // WHEN
        do {
            _ = try parser.parse(Data())
            XCTFail()
        } catch {
            // THEN
            XCTAssertTrue(true)
        }
    }
}
