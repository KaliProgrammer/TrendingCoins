//
//  DescriptionViewController.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class DescriptionViewController: UIViewController {
    var descriptionView = DescriptionView()
    var coin: Datum
    var cancellables = Set<AnyCancellable>()

    
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
        setupBindings()
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
    func setupBindings() {
        let detailViewModel = DetailViewModel(coin: coin)
        detailViewModel.sendData()
        
        detailViewModel.priceUSDPublisher
            .sink { [weak self] price in
            self?.descriptionView.priceUSDLabel.text = price
        }
        .store(in: &cancellables)
        
        detailViewModel.percentPublisher
            .sink { [weak self] percent in
            self?.descriptionView.percentLabel.text = percent
        }
        .store(in: &cancellables)
        
        detailViewModel.priceDifferencePublisher
            .sink { [weak self] difference in
            self?.descriptionView.priceDifferenceLabel.text = difference
        }
        .store(in: &cancellables)
        
        detailViewModel.marketCapNumberPublisher
            .sink { [weak self] marketCap in
            self?.descriptionView.marketCapNumberLabel.text = marketCap
        }
        .store(in: &cancellables)
        
        detailViewModel.supplyNumberPublisher
            .sink { [weak self] supplyNumber in
            self?.descriptionView.supplyNumberLabel.text = supplyNumber
        }
        .store(in: &cancellables)
        
        detailViewModel.volume24HrNumberPublisher
            .sink { [weak self] volume24HrNumber in
            self?.descriptionView.volume24HrNumberLabel.text = volume24HrNumber
        }
        .store(in: &cancellables)
        
        detailViewModel.nameOfCurrencyPublisher
            .sink { [weak self] nameOfCurrency in
            self?.descriptionView.nameLabel.text = nameOfCurrency
        }
        .store(in: &cancellables)
   
        if (Double(coin.changePercent)) < 0 {
            self.descriptionView.percentLabel.textColor = UIColor.theme.percentColorMinus
            self.descriptionView.priceDifferenceLabel.textColor = UIColor.theme.percentColorMinus
        } else {
            self.descriptionView.percentLabel.textColor = UIColor.theme.percentColorPlus
            self.descriptionView.priceDifferenceLabel.textColor = UIColor.theme.percentColorPlus
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
