import UIKit

enum LaFourchetteModule {
    static var router: Router!
        private static let api = "http://api.lafourchette.com/api?%20key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=6861"
        
        static func restaurantViewController() -> UIViewController {
            let viewController = RestaurantViewController()
            let repository = RemoteRestaurantRepositoryImpl(api)
            let presenter = RestaurantPresenterImpl(view: viewController)
            viewController.controller = RestaurantController(
                with: RestaurantInteractorImpl(
                    remoteRepository: repository,
                    presenter: presenter
                )
            )
            return viewController
        }
}
