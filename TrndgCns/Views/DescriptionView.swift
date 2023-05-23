//
//  DescriptionView.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit
import SnapKit

class DescriptionView: UIView {
    
    //MARK: - UI Components
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-ExpandedSemibold", size: 24)
        return label
    }()

    lazy var priceUSDLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 24)
        return label
    }()
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        return label
    }()
    lazy var marketCapTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Market Cap") 
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var marketCapNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    lazy var supplyTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Supply")
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var supplyNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    lazy var volume24HrTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Volume 24Hr")
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var volume24HrNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    
    lazy var priceDifferenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup UI elements
    func setupElements() {
        addSubviews([priceUSDLabel,
                     percentLabel,
                     marketCapTextLabel,
                     marketCapNumberLabel,
                     supplyTextLabel, supplyNumberLabel,
                     volume24HrTextLabel,
                     volume24HrNumberLabel,
                     nameLabel,
                     priceDifferenceLabel])
            
        priceUSDLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(self.snp.top).offset(130)
            make.height.equalTo(29)
        }
        priceDifferenceLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceUSDLabel.snp.trailing).offset(10)
            make.trailing.equalTo(self.percentLabel.snp.leading).offset(-5)
            make.top.equalTo(self.snp.top).offset(138)
            make.height.equalTo(17)
        }
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceDifferenceLabel.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-90)
            make.top.equalTo(self.snp.top).offset(138)
            make.height.equalTo(17)
        }
        marketCapTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(priceUSDLabel.snp.bottom).offset(24)
            make.width.equalTo(95)
            make.height.equalTo(30)
        }
        supplyTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.marketCapTextLabel.snp.trailing).offset(42)
            make.top.equalTo(priceUSDLabel.snp.bottom).offset(24)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        volume24HrTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.supplyTextLabel.snp.trailing).offset(45)
            make.top.equalTo(priceUSDLabel.snp.bottom).offset(24)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        marketCapNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(marketCapTextLabel.snp.bottom).offset(2)
            make.width.equalTo(75)
            make.height.equalTo(19)
        }
        supplyNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.marketCapNumberLabel.snp.trailing).offset(63)
            make.top.equalTo(supplyTextLabel.snp.bottom).offset(2)
            make.height.equalTo(19)
        }
        volume24HrNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.supplyTextLabel.snp.trailing).offset(45)
            make.top.equalTo(volume24HrTextLabel.snp.bottom).offset(2)
            make.width.equalTo(60)
            make.height.equalTo(19)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(65)
            make.top.equalTo(self.snp.top).offset(38)
            make.height.equalTo(60)
            make.width.equalTo(300)
        }
    }
}
