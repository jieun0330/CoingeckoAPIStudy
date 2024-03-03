//
//  NewTopCoinTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit
import Then
import SnapKit

class NewTopCoinTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let topCoinLabel = UILabel().then {
        $0.text = "Top 15 Coin"
        $0.font = DesignSystemFont.trendingSubtitle.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: NewTopCoinTableViewCell.configureCollectionViewLayout()).then {
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewTopCoinCollectionViewCell.self, forCellWithReuseIdentifier: NewTopCoinCollectionViewCell.identifier)
//        $0.backgroundColor = .purple

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [topCoinLabel, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        topCoinLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = DesignSystemColor.white.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}



extension NewTopCoinTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
//    height
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewTopCoinCollectionViewCell.identifier, for: indexPath) as! NewTopCoinCollectionViewCell
        
//        cell.backgroundColor = .orange
        
        return cell
    }
    
    
}
