import Foundation

protocol RestaurantView : class {
    func showError(message: String)
    func showRestaurant(with restaurant: RestaurantViewModel)
}

class RestaurantPresenterImpl : RestaurantPresenter {
    private weak var view : RestaurantView?
    private let executor: Executor
    
    init(view: RestaurantView, executor: Executor = Executor()) {
        self.view = view
        self.executor = executor
    }
    
    func presentError() {
        executor.runOnMain {
            self.view?.showError(message:
                Message.noConnectionErrorMessage.localized
            )
        }
    }
    
    func present(with restaurant: Restaurant) {
        var menuChefOriginLabel: String? = nil
        if let chefName = restaurant.chefName {
            menuChefOriginLabel = Message.restaurantChefMenu.localizeWithFormat(arguments: chefName)
        }
        
        var score = Message.noScore.localized
        if let scoreAvg = restaurant.score.avg {
            score = String(scoreAvg)
        }
        
        var tripAdvisorScore = Message.noScore.localized
        if let tripAdvisorScoreAvg = restaurant.tripAdvisorScore.avg {
            tripAdvisorScore = Message.score.localizeWithFormat(arguments: tripAdvisorScoreAvg)
        }
        
        let restaurantViewModel = RestaurantViewModel(
            pictureURL: restaurant.pictureURL,
            title: restaurant.name,
            subtitle: restaurant.speciality,
            priceLabel: Message.averagePrice.localizeWithFormat(arguments: restaurant.cardPrice),
            scoreLabel: score, opinionLabel: Message.averageOpinion.localizeWithFormat(arguments: restaurant.score.count),
            description: restaurant.description,
            menuChefOriginLabel: menuChefOriginLabel,
            starters: transformMealToMealViewModel(restaurant.starters),
            meals: transformMealToMealViewModel(restaurant.meals),
            desserts: transformMealToMealViewModel(restaurant.desserts),
            menus: transformMenuToMenuViewModel(restaurant.menus),
            tripAdvisorScore: tripAdvisorScore,
            tripAdvisorCount: Message.averageOpinion.localizeWithFormat(arguments: restaurant.tripAdvisorScore.count)
        )
        executor.runOnMain {
            self.view?.showRestaurant(with: restaurantViewModel)
        }
    }
    
    private func getLabelForPrice(_ price: Float?) -> String {
        return price == nil ? Message.noPrice.localized : Message.price.localizeWithFormat(arguments: Int(price!))
    }
    
    private func getLabelForWeekTime(_ weekTime: WeekTime) -> String {
        switch weekTime {
        case .LUNCH_WEEK:
            return Message.lunchWeekLabel.localized
        case .LUNCH_WEEKEND:
            return Message.lunchWeekendLabel.localized
        case .DINER_WEEK:
            return  Message.dinerWeekLabel.localized
        case .DINER_WEEKEND:
            return  Message.dinerWeekendLabel.localized
        }
    }
    
    private func transformMealToMealViewModel(_ meals: [Meal]) -> [MealViewModel] {
        return meals.map({
            MealViewModel(
                name: $0.name,
                price: getLabelForPrice($0.price)
            )
        })
    }
    
    private func transformMenuToMenuViewModel(_ menus: [Menu]) -> [MenuViewModel] {
        return menus.map({
            MenuViewModel(
                name: getLabelForWeekTime($0.weekTime),
                price: getLabelForPrice($0.maxPrice)
            )
        })
    }
}
