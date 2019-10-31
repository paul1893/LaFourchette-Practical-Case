import Foundation

protocol RestaurantInteractor {
    func loadRestaurant()
}

final class RestaurantInteractorImpl : RestaurantInteractor {
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
        _ = remoteRepository.getRestaurant()
            .then { self.presenter.present(with: $0) }
            .catch { self.presenter.presentError() }
    }
}
