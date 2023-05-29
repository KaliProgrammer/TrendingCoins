//
//  MainViewController+Extension.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.coins.value.data.count)
        return viewModel.coins.value.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        let viewModel = viewModel.coins.value.data[indexPath.row]
        let logoViewModel = CoinLogoViewModel(coin: viewModel)
        cell.configure(using: viewModel)
        
        logoViewModel.coinImage.sink { image in
            cell.coinLogo.image = image
        }
        .store(in: &cancellable)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = viewModel.coins.value.data[indexPath.row]
        let viewModel = DetailViewModel(coin: list)
        let descriptionViewController = DescriptionViewController(viewModel.coin)
        navigationController?.pushViewController(descriptionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplay(itemAtIndex: indexPath.row)
    }
}
