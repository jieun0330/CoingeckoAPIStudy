//
//  TrendingViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import UIKit
import Then
import SnapKit

final class TrendingViewController: BaseViewController {
    
    let repository = repositoryCRUD()
    let viewModel = ViewModel()
    var realmList: [CoinRealmModel] = []
    
    //    lazy var tableView = UITableView().then {
    //        $0.delegate = self
    //        $0.dataSource = self
    //        $0.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: MyFavoriteTableViewCell.identifier)
    //    }
    
    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser.withRenderingMode(.alwaysOriginal),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Crypto Coin"
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    let myFavorite = UILabel().then {
        $0.text = "My Favorite"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    // TableView와 CollectionView 어떤걸 써야할지 몰라서 3분컷으로 써본 글입니다,, https://cyndi0330.tistory.com/41
    lazy var favoriteCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: TrendingViewController.favoriteCollectionViewLayout()).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(MyFavoriteCollectionViewCell.self,
                        forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
        }
    
    let topCoinLabel = UILabel().then {
        $0.text = "Top15 Coin"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    lazy var topCoinCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: TrendingViewController.topCoinCollectionViewLayout()).then {
        $0.backgroundColor = .green
        $0.delegate = self
        $0.dataSource = self
        $0.register(TopCoinCollectionViewCell.self,
                    forCellWithReuseIdentifier: TopCoinCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmList = repository.fetchAllItem()
        
        var idList = ""
        
        for list in realmList {
            idList.append(list.id + ",")
        }
        
        viewModel.inputViewTrigger.value = idList
        
        viewModel.outputCoinPriceAPI.bind { data in
            self.favoriteCollectionView.reloadData()
        }
    }
    
    // favorite 뷰에서 저장 누르고 다시 왔을 때 ?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteCollectionView.reloadData()
    }
    
    override func configureHierarchy() {
        //        [tableView].forEach {
        //            view.addSubview($0)
        //        }
        
        [mainTitle, myFavorite, favoriteCollectionView,
         topCoinLabel, topCoinCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        //        tableView.snp.makeConstraints {
        //            $0.edges.equalToSuperview()
        //        }
        
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
        
        favoriteCollectionView.snp.makeConstraints {
            $0.leading.equalTo(myFavorite.snp.leading)
            $0.top.equalTo(myFavorite.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        topCoinLabel.snp.makeConstraints {
            $0.leading.equalTo(favoriteCollectionView.snp.leading)
            $0.top.equalTo(favoriteCollectionView.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        topCoinCollectionView.snp.makeConstraints {
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = profileTabBarItem
        view.backgroundColor = DesignSystemColor.white.color
    }
    
    @objc func profileTabBarItemClicked() {
        
    }

    static func favoriteCollectionViewLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 1.5)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    static func topCoinCollectionViewLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 1.5)
        layout.itemSize = CGSize(width: cellWidth / 1.5, height: cellWidth / 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 30, bottom: spacing, right: spacing)
        
        return layout
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return repository.fetchAllItem().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == favoriteCollectionView {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyFavoriteCollectionViewCell.identifier, for: indexPath
            ) as! MyFavoriteCollectionViewCell
                        
            cell.backgroundColor = DesignSystemColor.lightGray.color
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            
            if !viewModel.outputCoinPriceAPI.value.isEmpty {
                let item = viewModel.outputCoinPriceAPI.value[indexPath.item]
                cell.name.text = item.name
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopCoinCollectionViewCell.identifier, for: indexPath)
            cell.backgroundColor = .orange
            
            return cell
        }
    }
}

//extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 100
//        }
//
//        return 50
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.row == 0 {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: MyFavoriteTableViewCell.identifier, for: indexPath)
//
//            return cell
//        }
//
//        return UITableViewCell()
//
//    }
//
//
//}

