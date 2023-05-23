//
//  SearchBar+Extension.swift
//  TrndgCns
//
//  Created by MacBook Air on 21.05.2023.
//

import Foundation
import UIKit

extension MainViewController: UISearchBarDelegate {
    
    //MARK: - SearchBar configuration

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getData(keyword: searchBar.text!)
        viewModel.coins.sink { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.customTableView.reloadData()
            
        }
        .store(in: &cancellable)
    }
}
