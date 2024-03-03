//
//  NewNTFTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

class NewNTFTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let viewModel = ViewModel()

    let topNFTLabel = UILabel().then {
        $0.text = "Top 7 NFT"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: NewNTFTableViewCell.configureCollectionViewLayout()).then {
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewNFTCollectionViewCell.self, forCellWithReuseIdentifier: NewNFTCollectionViewCell.identifier)
//        $0.backgroundColor = .purple

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [topNFTLabel, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        topNFTLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(topNFTLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = DesignSystemColor.white.color
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: cellWidth / 1.3, height: cellWidth / 4.8)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewNTFTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
//    height
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewNFTCollectionViewCell.identifier, for: indexPath) as! NewNFTCollectionViewCell
        
        
        if !viewModel.outputTrendingNFTAPI.value.isEmpty {
            let trending = viewModel.outputTrendingNFTAPI.value[indexPath.item]
            
            cell.name.text = trending.name
            cell.rankNum.text = "\(indexPath.item+1)"
            cell.image.kf.setImage(with: URL(string: trending.thumb))
            cell.price.text = trending.data.floorPrice
            cell.symbol.text = trending.symbol
//            let percentage = DesignSystemText.shared.percentageCalculator(number: krwKey["krw"]!)

            let percentage = DesignSystemText.shared.percentageCalculator(number: Double(trending.data.floorPriceInUsd24HPercentageChange)!)
            cell.percentage.text = percentage
//            print("percentage", percentage)
            
//            let krwKey: [String: Double] = trending.data.priceChangePercentage24H
//            let percentage = DesignSystemText.shared.percentageCalculator(number: krwKey["krw"]!)
//            cell.percentage.text = percentage
 

        }
        
        
        return cell
    }
    
    
}
