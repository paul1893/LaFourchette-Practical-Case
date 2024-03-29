import UIKit
import Foundation

final class Style {
    static let subbody = Style(font: Font.subbody, color: Color.secondTextColor)
    static let body = Style(font: Font.body, color: Color.mainTextColor)
    static let bodyColored = Style(font: Font.body, color: Color.mainColor)
    static let title = Style(font: Font.title, color: Color.mainTextColor)
    static let mainButton = Style(font: Font.body, color: Color.mainColor)
    
    let font: UIFont
    let color: UIColor
    
    init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

final class Font {
    static let title = UIFont.boldSystemFont(ofSize: 22.0)
    static let body = UIFont.boldSystemFont(ofSize: 16.0)
    static let subbody = UIFont.systemFont(ofSize: 14.0)
}

final class Margin {
    static let little : CGFloat = 16
    static let medium : CGFloat = 32
}

final class Color {
    static var mainColor: UIColor {
        get {
            if #available(iOS 11.0, *) {
                    return UIColor(named: "MainColor")!
                } else {
                    return UIColor(red: 0.404, green: 0.573, blue: 0.298, alpha: 1)
            }
        }
    }
    static var mainTextColor: UIColor {
           get {
               if #available(iOS 11.0, *) {
                       return UIColor(named: "MainTextColor")!
                   } else {
                       return UIColor.black
               }
           }
       }
    static var secondTextColor: UIColor {
        get {
            if #available(iOS 11.0, *) {
                    return UIColor(named: "SecondTextColor")!
                } else {
                    return UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1.0)
            }
        }
    }
    static var cardBackground: UIColor {
        get {
            if #available(iOS 11.0, *) {
                    return UIColor(named: "CardBackground")!
                } else {
                    return UIColor(red: 0.941, green: 0.941, blue: 0.941, alpha: 1.0)
            }
        }
    }
    static var background: UIColor {
        get {
            if #available(iOS 11.0, *) {
                    return UIColor(named: "Background")!
                } else {
                    return UIColor.white
            }
        }
    }
}

final class Message {
    static let baseNote = "/10"
    static let restaurantMenuTitleSection = "CARTE DU RESTAURANT"
    static let chefMenu = "Menu du chef - "
    static let seeAllRestaurantMenu = "VOIR LA CARTE ET LES MENUS"
    static let tripAdvisorTitleSection =  "NOTES & AVIS"
    static let reservationButtonTitle = "RÉSERVER - JUSQU'À -20%"
    static let seeAllScore = "VOIR TOUS LES AVIS"
    static let seeAll = "VOIR TOUT"
    static let errorTitle = "Oups!"
    static let noConnectionErrorMessage = "Vérifiez votre connexion internet"
    static let ok = "OK"
    static let lunchWeekLabel = "Seulement le midi"
    static let lunchWeekendLabel = "Seulement le midi (weekend)"
    static let dinerWeekLabel = "Seulement le soir"
    static let dinerWeekendLabel = "Seulement le soir (weekend)"
    static let restaurantChefMenu = "Extrait de la carte du Chef %@"
    static let noScore = "NC"
    static let score = "%.1f/10"
    static let averagePrice = "Prix moyen %d€"
    static let averageOpinion = "%d avis"
    static let noPrice = "- €"
    static let price = "%d €"
}
