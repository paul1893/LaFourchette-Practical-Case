@testable import LaFourchette

class MockExecutor : Executor {
    override func run(function: @escaping () -> ()) {
        function()
    }
    
    override func runOnMain(function: @escaping () -> ()) {
        function()
    }
}
