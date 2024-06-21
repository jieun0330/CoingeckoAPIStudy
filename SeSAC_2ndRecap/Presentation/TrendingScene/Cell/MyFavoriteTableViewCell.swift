//
//  NewTrendingTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

final class MyFavoriteTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let repository = RepositoryRealm()
    let viewModel = ViewModel()
    
    let myFavorite = UILabel().then {
        $0.text = "My Favorite"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(MyFavoriteCollectionViewCell.self,
                    forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
    }
    
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
            $0.top.equalTo(myFavorite.snp.bottom)
            $0.height.equalTo(180)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = DesignSystemColor.white.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 1.5)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        
        return layout
    }
}

extension MyFavoriteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return repository.fetchAllItem().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyFavoriteCollectionViewCell.identifier,
            for: indexPath) as! MyFavoriteCollectionViewCell
        
        cell.backgroundColor = DesignSystemColor.lightGray.color
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        if !viewModel.outputMarketAPI.value.isEmpty {
            let item = viewModel.outputMarketAPI.value[indexPath.item]
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = viewModel.outputMarketAPI.value[indexPath.item]
//        let vc = ChartViewController()
//        vc.data = item
    }
}
