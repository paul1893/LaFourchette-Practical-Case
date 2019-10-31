import UIKit

protocol Router {
    func go(to: Link)
}

enum Link: Equatable {
    case restaurant
}

final class AppRouter {
    var mainViewController: UIViewController!
    
    func rootViewController() -> UIViewController {
        return LaFourchetteModule.restaurantViewController()
    }
    
    fileprivate func showRestaurantViewController() {
        mainViewController = LaFourchetteModule.restaurantViewController()
    }
}

extension AppRouter: Router {
    func go(to link: Link) {
        switch link {
        case .restaurant: showRestaurantViewController()
        }
    }
}
