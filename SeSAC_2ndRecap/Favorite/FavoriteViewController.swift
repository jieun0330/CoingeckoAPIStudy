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
    
    let repository = repositoryCRUD()
    let viewModel = FavoriteViewModel()
    // 즐겨찾기 되어있는 코인 모음집
    var realmList: [CoinRealmModel] = []
    
    // 가격 포함되어있는 API 호출 결과물
    var priceAPIResult: PriceAPI = []
    
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
        
        
    
//        realmList = repositoryCRUD.readItemName(id: <#T##String#>)
//        print("realmList", realmList)
        /*
         저장했을 경우
         realmList [CoinRealmModel {
             id = whitebit;
         }]
         */
        
        // 1. 저장되어있는것만 보여줘야 하니까 fetchAll을 해오지
        realmList = repository.fetchAllItem()
        print("realmList", realmList)
        /*
         realmList [CoinRealmModel {
             id = whitebit;
         }, CoinRealmModel {
             id = whisperbot;
         }, CoinRealmModel {
             id = whiteheart;
         }]
         */
        
        // 2. 이 중에 ID만 추출해올거야
//        var realmListID: [String] = []
        var test = ""

        for list in realmList {
            test.append(list.id + ",")
        }
        print("test", test) //whitebit,whisperbot,whiteheart,
        
        viewModel.inputViewDidLoadTrigger.value = test
        
        viewModel.outputPriceAPI.bind { data in
            self.priceAPIResult = data
            print("data", data)
        }
        
        print("realmList", realmList)
        print("priceapiresult", priceAPIResult)
        
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
        
        let item = priceAPIResult[indexPath.item]
        
        cell.name.text = item.name
        cell.icon.kf.setImage(with: URL(string: item.image))
        cell.symbol.text = item.symbol
        
        let coinPrice = DesignSystemText.shared.priceCalculator(item.currentPrice)
        cell.price.text = "₩\(coinPrice)"
    
        cell.percentage.text = DesignSystemText.shared.percentageCalculator(number: item.priceChangePercentage24H)
        
        if item.priceChangePercentage24H < 0 {
            cell.percentage.textColor = DesignSystemColor.red.color
        } else {
            cell.percentage.textColor = DesignSystemColor.blue.color
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        let item = priceAPIResult[indexPath.item]
        
        vc.name.text = item.name
        vc.icon.kf.setImage(with: URL(string: item.image))
        
        vc.percentage.text = DesignSystemText.shared.percentageCalculator(number: item.priceChangePercentage24H)
        
        if item.priceChangePercentage24H < 0 {
            vc.percentage.textColor = DesignSystemColor.red.color
        } else {
            vc.percentage.textColor = DesignSystemColor.blue.color
        }
        
        let coinPrice = DesignSystemText.shared.priceCalculator(item.currentPrice)
        vc.price.text = "₩\(coinPrice)"
        
        if repository.readItemName(id: item.id).first?.id == item.id {
            vc.rightFavoriteButton.image = .btnStarFill.withRenderingMode(.alwaysOriginal)
        } else{
            vc.rightFavoriteButton.image = .btnStar.withRenderingMode(.alwaysOriginal)
        }

    }
}
