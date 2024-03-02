//
//  FavoriteViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RealmSwift

class FavoriteViewController: BaseViewController {
    
    let repository = RepositoryRealm()
    let viewModel = ViewModel()
    
    var realmList: [CoinRealmModel] = []
    
    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Favorite Coin"
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FavoriteViewController.configureCollectionViewLayout()).then {
        $0.backgroundColor = DesignSystemColor.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmList = repository.fetchAllItem()
        //        print("realmList", realmList)
        /*
         realmList [CoinRealmModel {
         id = whitebit;
         }, CoinRealmModel {
         id = whisperbot;
         }, CoinRealmModel {
         id = whiteheart;
         }]
         */
        
        var searchID = ""
        
        for list in realmList {
            searchID.append(list.id + ",")
        }
        
        viewModel.inputViewTrigger.value = searchID
        
        viewModel.outputCoinPriceAPI.bind { data in
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        [mainTitle, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.rightBarButtonItem = profileTabBarItem
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2.4, height: cellWidth / 2.4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: spacing)
        return layout
    }
    
    @objc func profileTabBarItemClicked() {
        
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.fetchAllItem().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
                
        let item = viewModel.outputCoinPriceAPI.value[indexPath.item]
        let coinPrice = DesignSystemText.shared.priceCalculator(item.currentPrice)
        
        cell.name.text = item.name
        cell.icon.kf.setImage(with: URL(string: item.image))
        cell.symbol.text = item.symbol
        cell.price.text = "₩\(coinPrice)"
        cell.percentage.text = DesignSystemText.shared.percentageCalculator(number: item.priceChangePercentage24H)
        
        if item.priceChangePercentage24H < 0 {
            cell.percentage.textColor = DesignSystemColor.red.color
            cell.percentageBox.backgroundColor = DesignSystemColor.pink.color
        } else {
            cell.percentage.textColor = DesignSystemColor.blue.color
            cell.percentageBox.backgroundColor = DesignSystemColor.sky.color
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.outputCoinPriceAPI.value[indexPath.item]
        
        let vc = ChartViewController()
        vc.data = item
        self.navigationController?.pushViewController(vc, animated: true)

//        if repository.readItemName(id: data.id).first?.id == data.id {
//            self.rightFavoriteButton.image = .btnStarFill.withRenderingMode(.alwaysOriginal)
//        } else{
//            self.rightFavoriteButton.image = .btnStar.withRenderingMode(.alwaysOriginal)
//        }
    }
}
