//
//  SearchViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RealmSwift

class SearchViewController: BaseViewController {
    
    let viewModel = SearchViewModel()
    var apiResultList: [CoinAPI] = []
    let repository = CoinRepository()
    var realmList: Results<CoinRealmModel>!

    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Search"
        $0.font = DesignSystemFont.main.font
    }
    
    lazy var searchBar = UISearchBar().then {
        $0.placeholder = "코인명 검색"
        $0.backgroundImage = UIImage()
        $0.layer.cornerRadius = 10
        $0.delegate = self
    }
    
    lazy var tableView = UITableView().then {
        $0.backgroundColor = DesignSystemColor.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.rowHeight = 60
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 검색결과 API 호출
        viewModel.outputCoinData.bind { data in
            self.apiResultList = data
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        [mainTitle, searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {

        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(35)
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.rightBarButtonItem = profileTabBarItem
    }
    
    @objc func profileTabBarItemClicked() {
        
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // API 검색 결과 수
        return apiResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let row = apiResultList[indexPath.row]
        
        cell.icon.kf.setImage(with: URL(string: row.thumb))
        cell.name.text = row.name
        cell.symbol.text = row.symbol
        cell.favorites.tag = indexPath.row
        cell.favorites.setImage(.btnStar, for: .normal)
        cell.favorites.addTarget(self, action: #selector(favoritesButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func favoritesButtonClicked(_ sender: UIButton) {
        
        sender.setImage(.btnStarFill, for: .normal)
        
        
        // repository에 포함 안되어있으면 create를 하고
//        if realmList[sender.tag].favorites == false {
//            repository.createFavoriteItem(name: apiResultList[sender.tag].name)
//        } else {
//            repository.updateFavoriteItem(item: realmList[sender.tag])
//        }
        // repository에 포함이 되어있으면 updateFavorite만 하고
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputSearchBarTapped.value = searchBarText
    }
}
