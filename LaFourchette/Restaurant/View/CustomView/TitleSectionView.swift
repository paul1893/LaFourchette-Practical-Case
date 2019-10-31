import UIKit

final class TitleSectionView : UIView {
    private let DESCRIPTION_NUMBER_OF_LINES = 20
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let scoreLabel = UILabel()
    private let opinionLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeConstraints()
    }
    
    func showData(for restaurant: RestaurantViewModel) {
        showTitle(restaurant)
        showPrice(restaurant)
        showScore(restaurant)
        showOpinion(restaurant)
        showDescription(restaurant)
    }
    
    private func showTitle(_ restaurant: RestaurantViewModel) {
        titleLabel.text = restaurant.subtitle
        titleLabel.setTextStyle(Style.body)
    }
    
    private func showPrice(_ restaurant: RestaurantViewModel) {
        priceLabel.text = restaurant.priceLabel
        priceLabel.setTextStyle(Style.subbody)
    }
    
    private func showScore(_ restaurant: RestaurantViewModel) {
        let bigBoldString = NSMutableAttributedString(
            string: restaurant.scoreLabel,
            attributes:[NSAttributedString.Key.font : Font.title]
        )
        let boldString = NSMutableAttributedString(
            string: Message.baseNote.localized,
            attributes:[NSAttributedString.Key.font : Font.body]
        )
        bigBoldString.append(boldString)
        scoreLabel.attributedText = bigBoldString
        scoreLabel.setTextStyle(Style.title)
        scoreLabel.textAlignment = .right
    }
    
    private func showOpinion(_ restaurant: RestaurantViewModel) {
        opinionLabel.text = restaurant.opinionLabel
        opinionLabel.setTextStyle(Style.subbody)
        opinionLabel.textAlignment = .right
    }
    
    private func showDescription(_ restaurant: RestaurantViewModel) {
        descriptionLabel.text = restaurant.description
        descriptionLabel.numberOfLines = DESCRIPTION_NUMBER_OF_LINES
        descriptionLabel.textAlignment = .justified
        descriptionLabel.setTextStyle(Style.subbody)
    }
    
    private func makeConstraints() {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        
        let titleAndPriceStackView = UIStackView()
        titleAndPriceStackView.axis = .vertical
        titleAndPriceStackView.addArrangedSubview(titleLabel)
        titleAndPriceStackView.addArrangedSubview(priceLabel)
        horizontalStackView.addArrangedSubview(titleAndPriceStackView)
        
        let scoreAndOpinionStackView = UIStackView()
        scoreAndOpinionStackView.axis = .vertical
        scoreAndOpinionStackView.addArrangedSubview(scoreLabel)
        scoreAndOpinionStackView.addArrangedSubview(opinionLabel)
        horizontalStackView.addArrangedSubview(scoreAndOpinionStackView)
        
        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(
            equalTo: horizontalStackView.bottomAnchor,
            constant: Margin.little
        ).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
