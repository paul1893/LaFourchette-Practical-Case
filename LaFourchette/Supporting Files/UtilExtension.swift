import UIKit

extension String {
    func localizeWithFormat(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIButton {
    func setTextStyle(_ newValue: Style) {
        setTitleColor(Color.secondTextColor, for: .highlighted)
        backgroundColor = newValue.color
    }
}

extension UILabel {
    func setTextStyle(_ newValue: Style) {
        textColor = newValue.color
        font = newValue.font
    }
}
