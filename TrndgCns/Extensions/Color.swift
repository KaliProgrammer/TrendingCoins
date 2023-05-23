//
//  Color.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit

//MARK: - Custom color for UI Elements

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = UIColor(named: "background")
    let textColor = UIColor(named: "textColor")
    let percentColorPlus = UIColor(named: "percentColor(+)")
    let percentColorMinus = UIColor(named: "percentColor(-)")

}
