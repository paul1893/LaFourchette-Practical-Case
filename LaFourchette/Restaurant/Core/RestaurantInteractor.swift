import Foundation

protocol RestaurantInteractor {
    func loadRestaurant()
}

class RestaurantInteractorImpl : RestaurantInteractor {
    private let remoteRepository: RemoteRestaurantRepository
    private let presenter: RestaurantPresenter
    
    init(
        remoteRepository : RemoteRestaurantRepository,
        presenter: RestaurantPresenter
    ) {
        self.remoteRepository = remoteRepository
        self.presenter = presenter
    }
    
    func loadRestaurant() {
        do {
            let restaurant = try remoteRepository.getRestaurant()
            presenter.present(with: restaurant)
        } catch {
            presenter.presentError()
        }
    }
}
