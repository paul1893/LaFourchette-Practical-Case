import UIKit

class TripAdvisorSectionView : UIView {
    private let titleLabel = UILabel()
    private let scoreLabel = UILabel()
    private let countLabel = UILabel()
    private let horizontalStackView = UIStackView()
    private let seeAllScore = UILabel()
    
    private let ICON_WIDTH : CGFloat = 50
    private let ICON_HEIGHT : CGFloat = 25
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeConstraints()
    }
    
    func showData(for restaurant: RestaurantViewModel) {
        showTitle(restaurant)
        showScore(restaurant)
        showCount(restaurant)
        showSeeAll(restaurant)
    }
    
    private func showTitle(_ restaurant: RestaurantViewModel) {
        titleLabel.text = Message.tripAdvisorTitleSection.localized
        titleLabel.font = Font.body
    }
    
    private func showScore(_ restaurant: RestaurantViewModel) {
        scoreLabel.text = restaurant.tripAdvisorScore
        scoreLabel.font = Font.title
    }
    
    private func showCount(_ restaurant: RestaurantViewModel) {
        countLabel.text = restaurant.tripAdvisorCount
        countLabel.textColor = Color.secondTextColor
    }
    
    private func showSeeAll(_ restaurant: RestaurantViewModel) {
        seeAllScore.text = Message.seeAllScore.localized
        seeAllScore.textColor = Color.mainColor
        seeAllScore.font = Font.body
        seeAllScore.textAlignment = .center
    }
    
    private func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.little).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(seeAllScore)
        seeAllScore.translatesAutoresizingMaskIntoConstraints = false
        seeAllScore.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: Margin.medium).isActive = true
        seeAllScore.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        seeAllScore.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let grayView = UIView()
        addSubview(grayView)
        grayView.backgroundColor = Color.cardBackground
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.topAnchor.constraint(equalTo: seeAllScore.bottomAnchor, constant: Margin.little).isActive = true
        grayView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        grayView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        grayView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        grayView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: Margin.medium).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: Margin.little).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -Margin.little).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -Margin.medium).isActive = true
        
        let iconImageView = UIImageView()
        horizontalStackView.addArrangedSubview(iconImageView)
        iconImageView.image = UIImage(named: "tripadvisor")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: ICON_WIDTH).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: ICON_HEIGHT).isActive = true
        
        horizontalStackView.addArrangedSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor).isActive = true
        
        let seeAllCount = UILabel()
        horizontalStackView.addArrangedSubview(seeAllCount)
        seeAllCount.text = Message.seeAll.localized
        seeAllCount.textColor = Color.mainColor
        seeAllCount.font = Font.body
    }
}
