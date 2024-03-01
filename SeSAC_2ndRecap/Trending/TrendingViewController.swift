//
//  TrendingViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import UIKit
import Then
import SnapKit

class TrendingViewController: BaseViewController {
    
    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Crypto Coin"
        $0.font = DesignSystemFont.allMain.font
    }
    
    let myFavorite = UILabel().then {
        $0.text = "My Favorite"
        $0.font = DesignSystemFont.trendingSubtitle.font
//        $0.layer.borderColor = UIColor.red.cgColor
//        $0.layer.borderWidth = 1
    }
    
    let favoriteTableView = UITableView().then {
        $0.backgroundColor = .orange
    }
    
    let topCoinLabel = UILabel().then {
        $0.text = "Top15 Coin"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    let topCoinTableView = UITableView().then {
        $0.backgroundColor = .green
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [mainTitle, myFavorite, favoriteTableView, topCoinLabel, topCoinTableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        myFavorite.snp.makeConstraints {
            $0.leading.equalTo(mainTitle.snp.leading)
            $0.top.equalTo(mainTitle.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        favoriteTableView.snp.makeConstraints {
            $0.leading.equalTo(myFavorite.snp.leading)
            $0.top.equalTo(myFavorite.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        topCoinLabel.snp.makeConstraints {
            $0.leading.equalTo(favoriteTableView.snp.leading)
            $0.top.equalTo(favoriteTableView.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        topCoinTableView.snp.makeConstraints {
            $0.leading.equalTo(topCoinLabel.snp.leading)
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(180)
        }
        
    }

    override func configureView() {
        navigationItem.rightBarButtonItem = profileTabBarItem
        view.backgroundColor = .white
    }
    
    @objc func profileTabBarItemClicked() {
        
    }
    
}
