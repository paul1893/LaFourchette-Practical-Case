import UIKit


final class MenuSectionView : UIView {
    private let titleLabel = UILabel()
    private let chefNameLabel = UILabel()
    private let mealAndMenuStackView = UIStackView()
    private let seeAllMenuLabel = UILabel()
    
    private let MENU_CHEF_NAME_STROKE_WIDTH = -3
    private let PRICE_RATIO : CGFloat = 0.33
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeConstraints()
    }
    
    func showData(for restaurant: RestaurantViewModel) {
        showTitle(restaurant)
        showChef(restaurant)
        showMeals(restaurant)
        showMenus(restaurant)
        showSeeAll()
    }
    
    private func showTitle(_ restaurant: RestaurantViewModel) {
        titleLabel.text = Message.restaurantMenuTitleSection.localized
        titleLabel.setTextStyle(Style.body)
    }
    
    private func showChef(_ restaurant: RestaurantViewModel) {
        if let menuChefOriginLabel = restaurant.menuChefOriginLabel {
            chefNameLabel.isHidden = false
            chefNameLabel.text = menuChefOriginLabel
            chefNameLabel.setTextStyle(Style.body)
        } else {
            chefNameLabel.isHidden = true
        }
    }
    
    private func showMeals(_ restaurant: RestaurantViewModel) {
        mealAndMenuStackView.spacing = Margin.little
        let meals = restaurant.starters + restaurant.meals + restaurant.desserts
        for meal in meals {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = Margin.little
            
            let nameLabel = UILabel()
            nameLabel.numberOfLines = 2
            nameLabel.text = meal.name
            nameLabel.setTextStyle(Style.subbody)
            stackView.addArrangedSubview(nameLabel)
            
            let priceLabel = UILabel()
            priceLabel.textAlignment = .center
            priceLabel.text = meal.price
            priceLabel.setTextStyle(Style.body)
            stackView.addArrangedSubview(priceLabel)
            
            priceLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, multiplier: PRICE_RATIO).isActive = true
            mealAndMenuStackView.addArrangedSubview(stackView)
        }
    }
    
    private func showMenus(_ restaurant: RestaurantViewModel) {
        for menu in restaurant.menus {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            
            let boldString = NSMutableAttributedString(
                string: Message.chefMenu.localized,
                attributes:[
                    NSAttributedString.Key.font : Font.body,
                    NSAttributedString.Key.foregroundColor : Color.mainTextColor,
                    NSAttributedString.Key.strokeWidth: MENU_CHEF_NAME_STROKE_WIDTH
                ]
            )
            let normalString = NSMutableAttributedString(
                string:menu.name,
                attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: UIFont.systemFontSize)]
            )
            boldString.append(normalString)
            
            let nameLabel = UILabel()
            nameLabel.attributedText = boldString
            nameLabel.setTextStyle(Style.subbody)
            stackView.addArrangedSubview(nameLabel)
            
            let priceLabel = UILabel()
            priceLabel.textAlignment = .center
            priceLabel.text = menu.price
            priceLabel.setTextStyle(Style.body)
            stackView.addArrangedSubview(priceLabel)
            
            priceLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, multiplier: PRICE_RATIO).isActive = true
            mealAndMenuStackView.addArrangedSubview(stackView)
        }
    }
    
    private func showSeeAll() {
        seeAllMenuLabel.text = Message.seeAllRestaurantMenu.localized
        seeAllMenuLabel.setTextStyle(Style.bodyColored)
        seeAllMenuLabel.textAlignment = .center
    }
    
    private func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(chefNameLabel)
        chefNameLabel.translatesAutoresizingMaskIntoConstraints = false
        chefNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.little).isActive = true
        chefNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        chefNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(mealAndMenuStackView)
        mealAndMenuStackView.axis = .vertical
        mealAndMenuStackView.translatesAutoresizingMaskIntoConstraints = false
        mealAndMenuStackView.topAnchor.constraint(equalTo: chefNameLabel.bottomAnchor, constant: Margin.little).isActive = true
        mealAndMenuStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        mealAndMenuStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(seeAllMenuLabel)
        seeAllMenuLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllMenuLabel.topAnchor.constraint(equalTo: mealAndMenuStackView.bottomAnchor, constant: Margin.medium).isActive = true
        seeAllMenuLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        seeAllMenuLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seeAllMenuLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
