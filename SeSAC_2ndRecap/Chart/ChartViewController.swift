//
//  ChartViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit
import DGCharts
import RealmSwift

// ChartView에서 보여줘야할 데이터가 SearchView에서 값이 전달되어야 할 것 같다
//protocol PassDataProtocol: Protocol {
//    func didSelectRowAt(indexPath: IndexPath)
//}

class ChartViewController: BaseViewController {
    
    let viewModel = ChartViewModel()
    var coinPriceAPIResult: PriceAPI = []
//    let repository = CoinRepository()
    
//    var passDelegate: PassDataProtocol?
    
    lazy var rightFavoriteButton = UIBarButtonItem(title: "",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(rightFavoriteButtonClicked)).then { _ in
                
    }
    
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    var name = UILabel().then {
        $0.font = DesignSystemFont.allMain.font
    }
    
    let price = UILabel().then {
        $0.font = DesignSystemFont.allMain.font
    }
    
    let percentage = UILabel().then {
        $0.text = "+3.22%"
        $0.textColor = .red
        $0.font = DesignSystemFont.percentage.font
    }
    
    let today = UILabel().then {
        $0.text = "Today"
        $0.font = DesignSystemFont.percentage.font
        $0.textColor = .lightGray
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ChartViewController.configureCollectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func configureHierarchy() {
        [icon, name, price, percentage, today, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(35)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(10)
            $0.top.equalTo(icon.snp.top)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        price.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.leading).offset(5)
            $0.top.equalTo(icon.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        percentage.snp.makeConstraints {
            $0.leading.equalTo(price.snp.leading)
            $0.top.equalTo(price.snp.bottom).offset(10)
            $0.width.equalTo(70)
        }
        
        today.snp.makeConstraints {
            $0.top.equalTo(percentage.snp.top)
            $0.leading.equalTo(percentage.snp.trailing)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(percentage.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(150)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = rightFavoriteButton
    }
    
    @objc func rightFavoriteButtonClicked(_ sender: UIButton) {
        
//        if name.text == coinPriceAPIResult[sender.tag]
        
//        sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        
//        UIBarButtonItem.image
//        UIBarButtonItem(image: .btnStarFill, style: .plain, target: <#T##Any?#>, action: <#T##Selector?#>)
//        print(#function)
        
//        if repository.readItemName(item: <#T##String#>)
        
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2.4, height: cellWidth / 5.7)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
}

extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as! PriceCollectionViewCell
        
//        passDelegate?.didSelectRowAt(indexPath: indexPath)
        
        return cell
    }
}
