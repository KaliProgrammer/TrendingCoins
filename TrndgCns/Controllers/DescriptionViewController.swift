//
//  DescriptionViewController.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit
import SnapKit

final class DescriptionViewController: UIViewController {
    var descriptionView = DescriptionView()
    var coin: Datum
    
    init(_ coin: Datum) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.view.backgroundColor = UIColor.theme.backgroundColor
        configureCoinDetails()
        setupNavBar()
    }
    
    @objc func goToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToHomeVC))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.theme.textColor
    }
    
    //Coins property configuration
    func configureCoinDetails() {
        descriptionView.priceUSDLabel.text = "$\(coin.price.asCurrencyWith2Decimals())"
        descriptionView.percentLabel.text = "(\(coin.changePercent.asPercentString()))"
        descriptionView.priceDifferenceLabel.text = "\(coin.priceDifference.asCurrencyWith2Decimals())"
        descriptionView.marketCapNumberLabel.text = "$\(coin.marketCapBillion.asCurrencyWith2Decimals())b"
        descriptionView.supplyNumberLabel.text = "\(coin.supplyMillion.asCurrencyWith2Decimals())m"
        descriptionView.volume24HrNumberLabel.text = "$\(coin.volumeBillion.asCurrencyWith2Decimals())b"
        descriptionView.nameLabel.text = coin.nameCoin

        if (Double(coin.changePercent)) < 0 {
            self.descriptionView.percentLabel.textColor = UIColor.theme.percentColorMinus
            self.descriptionView.priceDifferenceLabel.textColor = UIColor.theme.percentColorMinus
        } else {
            self.descriptionView.percentLabel.textColor = UIColor.theme.percentColorPlus
            self.descriptionView.priceDifferenceLabel.textColor = UIColor.theme.percentColorPlus
            self.descriptionView.priceDifferenceLabel.text = "+\(coin.priceDifference.asCurrencyWith2Decimals())"
        }
    }
    
    //Setup UI elements
    func setupUI() {
        view.addSubview(descriptionView)
        descriptionView.backgroundColor = UIColor.theme.backgroundColor
        descriptionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(300)
        }
    }
}
