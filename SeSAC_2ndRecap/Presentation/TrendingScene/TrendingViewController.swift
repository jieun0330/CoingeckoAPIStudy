//
//  NewTrendingViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

final class TrendingViewController: BaseViewController {
    
    private let viewModel = ViewModel()
    var priceAPIResult: PriceAPI = []
    var topCoinAPIResult: [Coin] = []
    var topNFTAPIResult: [Nft] = []
    
    lazy var profileTabBarItem = UIBarButtonItem(image: DesignSystemImage.user.image,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Crypto Coin"
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(MyFavoriteTableViewCell.self,
                    forCellReuseIdentifier: MyFavoriteTableViewCell.identifier)
        $0.register(TopCoinTableViewCell.self,
                    forCellReuseIdentifier: TopCoinTableViewCell.identifier)
        $0.register(NTFTableViewCell.self,
                    forCellReuseIdentifier: NTFTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    // 즐겨찾기 저장 누르고 다시 왔을 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.idList()
        
        viewModel.outputMarketAPI.bind { data in
            self.priceAPIResult = data
            self.tableView.reloadData()
        }
        
        viewModel.outputTrendingCoinAPI.bind { data in
            self.topCoinAPIResult = data
            self.tableView.reloadData()
        }
    
        viewModel.outputTrendingNFTAPI.bind { data in
            self.topNFTAPIResult = data
            self.tableView.reloadData()
        }
        
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        [mainTitle, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(35)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.rightBarButtonItem = profileTabBarItem
    }
    
    @objc func profileTabBarItemClicked() { }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 220
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFavoriteTableViewCell.identifier,
                                                     for: indexPath) as! MyFavoriteTableViewCell
            
            cell.viewModel.outputMarketAPI.value = priceAPIResult
            cell.collectionView.reloadData()
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCoinTableViewCell.identifier,
                                                     for: indexPath) as! TopCoinTableViewCell
            
            cell.viewModel.outputTrendingCoinAPI.value = topCoinAPIResult
            cell.collectionView.reloadData()
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NTFTableViewCell.identifier,
                                                     for: indexPath) as! NTFTableViewCell
            
            cell.viewModel.outputTrendingNFTAPI.value = topNFTAPIResult
            cell.collectionView.reloadData()
            return cell
        }
    }
}
