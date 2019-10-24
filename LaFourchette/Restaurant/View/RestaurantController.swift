import Foundation

class RestaurantController {
    private let interactor: RestaurantInteractor
    private let executor: Executor
    
    init(
        with interactor: RestaurantInteractor,
        executor: Executor = Executor()
        ) {
        self.interactor = interactor
        self.executor = executor
    }
    
    func viewDidLoad() {
        executor.run { [weak self] in
            self?.interactor.loadRestaurant()
        }
    }
}
