//
//  NewTrendingTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

class NewMyFavoriteTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let repository = RepositoryRealm()
    let viewModel = ViewModel()
    var realmList: [CoinRealmModel] = []
    let priceAPIResult: PriceAPI = []

    
    let myFavorite = UILabel().then {
        $0.text = "My Favorite"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: NewMyFavoriteTableViewCell.configureCollectionViewLayout()).then {
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewMyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: NewMyFavoriteCollectionViewCell.identifier)
//        $0.backgroundColor = .purple

    }

//    lazy var collectionView = UICollectionView(frame: .zero,
//                                               collectionViewLayout: TrendingViewController.favoriteCollectionViewLayout()).then {

//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    override func configureHierarchy() {
        [myFavorite, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        myFavorite.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(myFavorite.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = DesignSystemColor.white.color
        

//        viewModel.outputCoinPriceAPI.bind { data in
//            self.favoriteCollectionView.reloadData()
//        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        
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
}


extension NewMyFavoriteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.fetchAllItem().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewMyFavoriteCollectionViewCell.identifier, for: indexPath) as! NewMyFavoriteCollectionViewCell
        
        cell.backgroundColor = DesignSystemColor.lightGray.color
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        
        
        
        if !viewModel.outputCoinPriceAPI.value.isEmpty {
            let item = viewModel.outputCoinPriceAPI.value[indexPath.item]
            
            
            cell.name.text = item.name
            cell.icon.kf.setImage(with: URL(string: item.image))
            cell.symbol.text = item.symbol
            let price = DesignSystemText.shared.priceCalculator(item.currentPrice)
            cell.price.text = "₩\(price)"
            let percentage = DesignSystemText.shared.percentageCalculator(number: item.priceChangePercentage24H)
            cell.percentage.text = percentage
        
        }
        
        return cell
    }
    
    
}
