//
//  TopCoinCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import UIKit
import Then
import SnapKit

class TopCoinCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {

//    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>).then {
//        $0.backgroundColor = .yellow
//        $0.delegate = self
//        $0.dataSource = self
//        $0.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
//    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
//        [collectionView].forEach {
//            contentView.addSubview($0)
//        }
    }
    
    override func configureConstraints() {
//        collectionView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    static func configureRankCollectionViewLayout() {
//        let layout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 10
//        let cellWidth = UIScreen.main.bounds.width - (spacing * 2)
//        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2)
//        layout.minimumLineSpacing = spacing
//        layout.minimumInteritemSpacing = spacing
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
//        
//        
//    }
    
}

//extension TopCoinCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCollectionViewCell.identifier, for: indexPath)
//        
//        return cell
//    }
//    
//    
//}
