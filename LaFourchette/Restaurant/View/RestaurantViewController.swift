import UIKit

class RestaurantViewController: UIViewController, RestaurantView {
    
    var controller:  RestaurantController!
    
    private let mainScrollView = UIScrollView()
    private let contentScrollView = UIView()
    private let headerImageView = UIImageView()
    private let titleLabel = UILabel()
    private let titleSectionView = TitleSectionView()
    private let menuSectionView = MenuSectionView()
    private let tripAdvisorSectionView = TripAdvisorSectionView()
    private let reservationButton = UIButton()
    
    private let HEADER_IMAGE_HEIGHT : CGFloat = 275
    private let RESERVATION_BUTTON_CORNER_RADIUS : CGFloat = 15
    private let RESERVATION_BUTTON_WIDTH_RATIO : CGFloat = 0.75
    private let RESERVATION_BUTTON_HEIGHT : CGFloat = 64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        controller.viewDidLoad()
        addViews()
        initConstraints()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(
            title: Message.errorTitle.localized,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Message.ok.localized, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showRestaurant(with restaurant: RestaurantViewModel) {
        if let pictureURLString = restaurant.pictureURL, let pictureURL = URL(string: pictureURLString) {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let imageData: Data = try Data(contentsOf: pictureURL)
                    DispatchQueue.main.async {
                        self.headerImageView.image = UIImage(data: imageData)
                    }
                } catch{
                    print(error)
                }
            }
        }
        titleLabel.text = restaurant.title
        titleLabel.textColor = restaurant.pictureURL != nil ? UIColor.white : UIColor.black
        titleLabel.font = Font.title
        
        titleSectionView.showData(for: restaurant)
        menuSectionView.showData(for: restaurant)
        tripAdvisorSectionView.showData(for: restaurant)
    }
    
    private func addViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentScrollView)
        contentScrollView.addSubview(headerImageView)
        headerImageView.image = UIImage(named: "placeholder")
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        contentScrollView.addSubview(titleLabel)
        contentScrollView.addSubview(titleSectionView)
        contentScrollView.addSubview(menuSectionView)
        contentScrollView.addSubview(tripAdvisorSectionView)
    }
    
    private func initConstraints() {
        initScrollViewConstraints()
        initHeaderConstraints()
        initTitleSectionConstraints()
        initMenuSectionConstraints()
        initTripAdvisorSectionConstraints()
        initReservationButtonConstraints()
    }
    
    private func initScrollViewConstraints() {
        var rootLeadingAnchor = view.leadingAnchor
        var rootTrailingAnchor = view.trailingAnchor
        if #available(iOS 11.0, *) {
            rootLeadingAnchor = view.safeAreaLayoutGuide.leadingAnchor
            rootTrailingAnchor = view.safeAreaLayoutGuide.trailingAnchor
        }
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.leadingAnchor.constraint(equalTo: rootLeadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: rootTrailingAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        contentScrollView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        let heightConstraint = contentScrollView.heightAnchor.constraint(equalTo: mainScrollView.heightAnchor, multiplier: 1)
        heightConstraint.priority = UILayoutPriority.defaultLow
        heightConstraint.isActive = true
        contentScrollView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func initHeaderConstraints() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: HEADER_IMAGE_HEIGHT).isActive = true
        headerImageView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 1).isActive = true
        headerImageView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -Margin.medium).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: Margin.little).isActive = true
    }
    
    private func initTitleSectionConstraints() {
        titleSectionView.translatesAutoresizingMaskIntoConstraints = false
        titleSectionView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Margin.medium).isActive = true
        titleSectionView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: Margin.little).isActive = true
        titleSectionView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -Margin.little).isActive = true
    }
    
    private func initMenuSectionConstraints() {
        menuSectionView.translatesAutoresizingMaskIntoConstraints = false
        menuSectionView.topAnchor.constraint(equalTo: titleSectionView.bottomAnchor, constant: Margin.medium).isActive = true
        menuSectionView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: Margin.little).isActive = true
        menuSectionView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: Margin.little).isActive = true
    }
    
    private func initTripAdvisorSectionConstraints() {
        let footerHeight = 3*Margin.medium
        tripAdvisorSectionView.translatesAutoresizingMaskIntoConstraints = false
        tripAdvisorSectionView.topAnchor.constraint(equalTo: menuSectionView.bottomAnchor, constant: Margin.medium).isActive = true
        tripAdvisorSectionView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: Margin.little).isActive = true
        tripAdvisorSectionView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -Margin.little).isActive = true
        tripAdvisorSectionView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -footerHeight).isActive = true
    }
    
    private func initReservationButtonConstraints() {
        view.addSubview(reservationButton)
        reservationButton.setTitle(Message.reservationButtonTitle.localized, for: .normal)
        reservationButton.setTitleColor(Color.secondTextColor, for: .highlighted)
        reservationButton.backgroundColor = Color.mainColor
        reservationButton.layer.cornerRadius = RESERVATION_BUTTON_CORNER_RADIUS
        reservationButton.clipsToBounds = true
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        reservationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Margin.medium).isActive = true
        reservationButton.widthAnchor.constraint(
            equalTo: contentScrollView.widthAnchor,
            multiplier: RESERVATION_BUTTON_WIDTH_RATIO
        ).isActive = true
        reservationButton.heightAnchor.constraint(equalToConstant: RESERVATION_BUTTON_HEIGHT).isActive = true
        reservationButton.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
    }
}

