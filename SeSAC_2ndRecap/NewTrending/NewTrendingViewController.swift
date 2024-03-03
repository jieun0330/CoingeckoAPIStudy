//
//  NewTrendingViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

class NewTrendingViewController: BaseViewController {
    
    let repository = RepositoryRealm()
    var realmList: [CoinRealmModel] = []
    let viewModel = ViewModel()

    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser.withRenderingMode(.alwaysOriginal),
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
        $0.register(NewMyFavoriteTableViewCell.self, forCellReuseIdentifier: NewMyFavoriteTableViewCell.identifier)
        $0.register(NewTopCoinTableViewCell.self, forCellReuseIdentifier: NewTopCoinTableViewCell.identifier)
//        $0.backgroundColor = .orange
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    override func configureHierarchy() {
        [mainTitle, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }

        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }

    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.rightBarButtonItem = profileTabBarItem
        
    }
    
    @objc func profileTabBarItemClicked() {
        
    }

}

extension NewTrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 220
        } else {
            return 350
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NewMyFavoriteTableViewCell.identifier, for: indexPath)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NewTopCoinTableViewCell.identifier, for: indexPath)
            
            return cell
        }
        

    }
    
    
}
