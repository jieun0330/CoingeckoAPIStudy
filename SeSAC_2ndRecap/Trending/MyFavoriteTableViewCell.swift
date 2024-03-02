//
//  MyFavoriteTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/2/24.
//

//import UIKit
//import Then
//import SnapKit
//
//class MyFavoriteTableViewCell: BaseTableViewCell, ReusableProtocol {

//    lazy var collectionView = UICollectionView(frame: .zero,
//                                               collectionViewLayout: TrendingViewController.favoriteCollectionViewLayout()).then {
//        $0.delegate = self
//        $0.dataSource = self
//        $0.register(MyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
//    }
//    
//    lazy var favoriteCollectionView = UICollectionView(frame: .zero,
//                                                       collectionViewLayout: TrendingViewController.favoriteCollectionViewLayout()).then {
//        
//        $0.delegate = self
//        $0.dataSource = self
//        $0.register(MyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
//    }

//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super .init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    
//    override func configureHierarchy() {
//        [collectionView].forEach {
//            contentView.addSubview($0)
//        }
//    }
//    
//    override func configureConstraints() {
//        collectionView.snp.makeConstraints {
//            $0.edges.equalTo(contentView)
//        }
//    }
//    
//    override func configureView() {
//        contentView.backgroundColor = .orange
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension MyFavoriteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFavoriteCollectionViewCell.identifier, for: indexPath)
//        
//        return cell
//    }
//    
//    
//}
