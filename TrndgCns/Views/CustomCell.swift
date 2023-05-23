//
//  CustomCell.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    //MARK: - UI Components
    
    lazy var coinLogo: UIImageView = {
        let coinLogo = UIImageView()
        coinLogo.layer.masksToBounds = true
        coinLogo.clipsToBounds = true
        //coinLogo.backgroundColor = .red
        coinLogo.layer.cornerRadius = 12
        return coinLogo
    }()
    
    private lazy var coinNameLabel: UILabel = {
        let coinName = UILabel()
        coinName.font = UIFont(name: "SFPro-Regular", size: 16)
        return coinName
    }()
    
    private lazy var coinSymbolLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.font = UIFont(name: "SFPro-Regular", size: 16)
        coinLabel.textColor = .gray
        return coinLabel
        
    }()
    
    private lazy var priceUSDLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont(name: "SFPro-Regular", size: 16)
        priceLabel.textAlignment = .right
        return priceLabel
        
    }()
    
    private lazy var changePercent24Hr: UILabel = {
        let percentLabel = UILabel()
        percentLabel.textAlignment = .right
        percentLabel.font = UIFont(name: "SFPro-Regular", size: 14)
        return percentLabel
        
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        coinLogo.image = nil
        coinNameLabel.text = ""
        coinSymbolLabel.text = ""
        priceUSDLabel.text = ""
        changePercent24Hr.text = ""
    }
    
    //Property configuration with viewModel
    func configure(using viewModel: Datum ) {
        self.coinNameLabel.text = viewModel.name
        self.coinSymbolLabel.text = viewModel.symbol
        self.priceUSDLabel.text = "$\(viewModel.price.asCurrencyWith2Decimals())"
        self.changePercent24Hr.text = "\(viewModel.changePercent.asPercentString())"
        if Double(viewModel.changePercent24Hr ?? "") ?? 0.0 > 0 {
            self.changePercent24Hr.text = "+\(viewModel.changePercent.asPercentString())"
        }
        if Double(viewModel.changePercent24Hr ?? "") ?? 0.0 < 0 {
            self.changePercent24Hr.textColor = UIColor.theme.percentColorMinus
        } else {
            self.changePercent24Hr.textColor = UIColor.theme.percentColorPlus
        }
    }
    
    //Setup UI elements
    private func setupElements() {
        addSubviews([coinLogo,
                     coinNameLabel,
                     coinSymbolLabel,
                     priceUSDLabel,
                     changePercent24Hr])
        coinLogo.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.top.equalTo(11)
            make.height.width.equalTo(48)
        }
        coinNameLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.leading.equalTo(self.coinLogo.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-50)
            make.height.equalTo(19)
        }
        coinSymbolLabel.snp.makeConstraints { make in
            make.top.equalTo(self.coinNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(self.coinLogo.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-240)
            make.height.equalTo(19)
        }
        priceUSDLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.leading.equalTo(self.contentView.snp.leading).offset(255)
            make.height.equalTo(19)
        }
        changePercent24Hr.snp.makeConstraints { make in
            make.top.equalTo(self.priceUSDLabel.snp.bottom).offset(2)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.leading.equalTo(self.contentView.snp.leading).offset(290)
            make.height.equalTo(19)
        }
    }
}
