//
//  SearchViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RealmSwift
import Toast

class SearchViewController: BaseViewController {

    let viewModel = SearchViewModel()
    let repository = repositoryCRUD()
    var coinInfoAPIResultList: [InfoAPI] = []
    var coinPriceAPIResultList: PriceAPI = []
    var realmList: [CoinRealmModel] = []
    
    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Search"
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    lazy var searchBar = UISearchBar().then {
        $0.placeholder = "코인명 검색"
        $0.backgroundImage = UIImage()
        $0.layer.cornerRadius = 10
        $0.delegate = self
        // [UIKeyboardTaskQueue lockWhenReadyForMainThread] timeout waiting for task on queue 뜨는 오류로 키보드가 등장할 때 앱 동작에 문제가 발생, '수정 제안'이 등장할 때 문제가 있어서 '수정 제안' 자체를 숨기는 두가지 코드
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    lazy var tableView = UITableView().then {
        $0.backgroundColor = DesignSystemColor.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.rowHeight = 60
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 검색결과 API 호출
        viewModel.outputCoinInfoData.bind { data in
            self.coinInfoAPIResultList = data
            self.tableView.reloadData()
        }
        
        viewModel.outputCoinPriceData.bind { data in
//            print("data", data)
            /*
             data [SeSAC_2ndRecap.Price(id: "whiteheart", symbol: "white", name: "Whiteheart", image: "https://assets.coingecko.com/coins/images/13484/large/whiteheart.png?1696513245", currentPrice: 7774341, high24H: 7937170, low24H: 7346073, priceChangePercentage24H: 4.88268, ath: 7937170, athDate: "2024-02-29T16:45:38.733Z", roi: nil, lastUpdated: "2024-02-29T18:28:39.829Z")]
             */
            self.coinPriceAPIResultList = data
//            print("coinPriceAPIResultList.count", self.coinPriceAPIResultList.count) // 1개
        }
    }
    
    override func configureHierarchy() {
        [mainTitle, searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(35)
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.rightBarButtonItem = profileTabBarItem
    }
    
    @objc func profileTabBarItemClicked() {
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // API 검색 결과 수
        return coinInfoAPIResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let row = coinInfoAPIResultList[indexPath.row]
        
        cell.icon.kf.setImage(with: URL(string: row.large))
        cell.name.text = row.name
        cell.symbol.text = row.symbol
        cell.favorites.tag = indexPath.row
        
        // Realm에 api 결과가 속해있으면
        if repository.readItemName(id: row.id).first?.id == row.id {
            // ⭐️ 표시
            cell.favorites.setImage(.btnStarFill, for: .normal)
        } else {
            cell.favorites.setImage(.btnStar, for: .normal)
        }
        
        cell.favorites.addTarget(self, action: #selector(favoritesButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ChartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        let coinInfo = coinInfoAPIResultList[indexPath.row]
//        print("coinInfo", coinInfo) // ✅
        
//        print("coinPriceAPIResultList[0]", coinPriceAPIResultList[0])
        /*
         Price(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 81667075.0, high24H: 84583677.0, low24H: 80891947.0, priceChangePercentage24H: -0.41735, ath: 85032453.0, athDate: "2024-02-28T17:20:23.244Z", roi: nil, lastUpdated: "2024-03-01T04:13:01.617Z")
         */

        // 차트화면 이름
        vc.name.text = coinInfo.name
        // 차트화면 아이콘 이미지
        vc.icon.kf.setImage(with: URL(string: coinInfo.large))
        
        // 가격 불러오기 위한 PriceAPI 호출
        viewModel.inputDidSelectRow.value = coinInfo.id
//        print("coinInfo.id", coinInfo.id) // ✅
        
        // 차트화면 가격
//        let priceForamtter = NumberFormatter()
//        func calculator(_ number: Double) -> String {
//            priceForamtter.numberStyle = .decimal
//            let result = priceForamtter.string(from: number as NSNumber)
//            return result ?? "0"
//        }
//        
//        let coinPrice = calculator(ceil(coinPriceAPIResultList[0].currentPrice)) // ceil: 소수점 올림
        
        let coinPrice = DesignSystemText.shared.calculator(coinPriceAPIResultList[0].currentPrice)
        vc.price.text = "₩\(coinPrice)"

        
        
        

        // 차트화면 %
        if coinPriceAPIResultList[0].priceChangePercentage24H < 0 {
            let percentage = String(format: "%.2f", coinPriceAPIResultList[0].priceChangePercentage24H)
            vc.percentage.text = "\(percentage)%"
            vc.percentage.textColor = .red
        } else {
            let percentage = String(format: "%.2f", coinPriceAPIResultList[0].priceChangePercentage24H)
            vc.percentage.text = "+\(percentage)%"
            vc.percentage.textColor = .blue
        }
        
        
    
        
        
        
        // ChartView 오른쪽 즐겨찾기 버튼
        if repository.readItemName(id: coinInfo.id).first?.id == coinInfo.id {
            vc.rightFavoriteButton.image = .btnStarFill.withRenderingMode(.alwaysOriginal)
        } else{
            vc.rightFavoriteButton.image = .btnStar.withRenderingMode(.alwaysOriginal)
        }
    }

    @objc func favoritesButtonClicked(_ sender: UIButton) {
        
        // 즐겨찾기 버튼을 눌렀을 때 해당 셀의 id를 램 형식에 맞게 저장해주기 위한 data
        let saveToRealm = CoinRealmModel(id: coinInfoAPIResultList[sender.tag].id)
//        print("saveToRealm", saveToRealm) // ✅

        // 실제 Realm에 저장되어있는 data
        let realmDatas = repository.readItemName(id: coinInfoAPIResultList[sender.tag].name)
//        print("realmDatas", realmDatas)
        /*
         item Results<CoinRealmModel> <0x109a46550> (
             [0] CoinRealmModel {
                 id = 65e0aa1d2831eeee2da3c033;
                 name = WhiteBIT Coin;
                 favorites = 0;
             },
         */
        
//        if saveToRealm.name == realmDatas[0].name { // item[0] -> repo에 아무것도 없을 수 있으니까 오류
        // 그리고 item[0]일 수가 없지, 계속 쌓이니까
        if realmDatas.contains(where: { data in
//            print("data", data)
            /*
             data CoinRealmModel {
                 id = 65e0ad3a6a116db69771a768;
                 name = Whiteheart;
                 favorites = 0;
             }
             */
            repository.deleteItem(item: data)

            return true
        }) {
            print("중복")
            self.view.makeToast("즐겨찾기에서 삭제되었습니다")
            tableView.reloadData()
        } else {
            // repository에 저장하기
            repository.createFavoriteItem(saveToRealm)
            // toast 메세지 띄워주기
            self.view.makeToast("즐겨찾기에 추가되었습니다")
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputSearchBarTapped.value = searchBarText
        view.endEditing(true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartPriceCollectionViewCell.identifier, for: indexPath) as! ChartPriceCollectionViewCell

        return cell
    }
    
    
}


//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as! PriceCollectionViewCell
//
//        return cell
//    }
