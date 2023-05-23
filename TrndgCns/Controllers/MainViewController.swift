//
//  MainViewController.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController {
    
    let viewModel = CoinsViewModel()
    var cancellable = Set<AnyCancellable>()
    
    //MARK: - UI Components
    
    lazy var customTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.theme.backgroundColor
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.tintColor = UIColor.theme.textColor
        return search
    }()
    
    private lazy var mainLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "SFPro-ExpandedSemibold", size: 24)
        name.text = String(localized: "Trending Coins")
        name.textColor = UIColor.theme.textColor
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refresh control
        customTableView.refreshControl = UIRefreshControl()
        customTableView.refreshControl?.addTarget(self,
                                                  action: #selector(didPullToRefresh),
                                                  for: .valueChanged)
        
        view.backgroundColor = UIColor.theme.backgroundColor
        customTableView.delegate = self
        customTableView.dataSource = self
        customTableView.backgroundColor = UIColor.theme.backgroundColor
        searchBar.delegate = self
        searchBar.sizeToFit()
        setupUI()
        viewModel.getData(keyword: searchBar.text!)
        
        //reloading tableView and getting data
        viewModel.coins.sink { [weak self] _ in
            self?.customTableView.reloadData()
        }
        .store(in: &cancellable)
        setupNavBar()
        showSearchBarButton(shouldShow: true)
    }
    
    @objc private func didPullToRefresh() {
        //Re-fetch data
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.customTableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func handleSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    //Search bar configuration
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
            navigationItem.rightBarButtonItem?.tintColor = UIColor.theme.textColor
            mainLabel.isHidden = false
            
        } else {
            navigationItem.rightBarButtonItem = nil
            mainLabel.isHidden = true
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        viewModel.getData(keyword: "")
    }
    
    //Setup UI elements
    private func setupUI() {
        view.addSubviews([customTableView,
                          mainLabel])
        customTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(110)
            make.bottom.equalToSuperview()
        }
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(20)
            make.top.equalTo(self.view.snp.top).offset(62)
            make.height.equalTo(32)
        }
    }
}
