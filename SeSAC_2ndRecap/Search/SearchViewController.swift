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
    let repository = CoinRepository()
    var coinInfoAPIResultList: [InfoAPI] = []
    var coinPriceAPIResultList: [PriceAPI] = []
    var realmList: [CoinRealmModel] = []
    
    lazy var profileTabBarItem = UIBarButtonItem(image: .tabUser,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(profileTabBarItemClicked))
    
    let mainTitle = UILabel().then {
        $0.text = "Search"
        $0.font = DesignSystemFont.main.font
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
        
//        viewModel.inputViewDidLoadTrigger.value = ()
        
        // 검색결과 API 호출
        viewModel.outputCoinInfoData.bind { data in
            self.coinInfoAPIResultList = data
            self.tableView.reloadData()
        }
        
        //
        viewModel.outputCoinPriceData.bind { data in
            print("data", data)
//            self.coinPriceAPIResultList[0] = data
            /*
             data [SeSAC_2ndRecap.Price(id: "whiteheart", symbol: "white", name: "Whiteheart", image: "https://assets.coingecko.com/coins/images/13484/large/whiteheart.png?1696513245", currentPrice: 7774341, high24H: 7937170, low24H: 7346073, priceChangePercentage24H: 4.88268, ath: 7937170, athDate: "2024-02-29T16:45:38.733Z", roi: nil, lastUpdated: "2024-02-29T18:28:39.829Z")]
             */
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
        if repository.readItemName(item: row.name).first?.name == row.name {
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
        // api 결과 이름 -> 차트화면 이름
        vc.name.text = coinInfo.name
        // api 결과 아이콘 -> 차트화면 아아이콘
        vc.icon.kf.setImage(with: URL(string: coinInfo.large))
        // api 결과 id -> 가격 불러오기 위한 PriceAPI 호출
        viewModel.inputDidSelectRow.value = coinInfo.id
        print("coinInfo.id", coinInfo.id)
        
        // ChartView 오른쪽 즐겨찾기 버튼
        if repository.readItemName(item: coinInfo.name).first?.name == coinInfo.name {
            vc.rightFavoriteButton.image = .btnStarFill.withRenderingMode(.alwaysOriginal)
        } else{
            vc.rightFavoriteButton.image = .btnStar.withRenderingMode(.alwaysOriginal)
        }
        
        
        
    }
    
//    @objc func chartViewRightBarButtonItemClicked() {
//        
//        print(#function)
//    }
    
    @objc func favoritesButtonClicked(_ sender: UIButton) {
        
        // 즐겨찾기 버튼을 눌렀을 때 해당 셀의 name을
        // 형식에 맞게 저장해주기 위한 data
        let saveToRealm = CoinRealmModel(name: coinInfoAPIResultList[sender.tag].name)
//        print("saveToRealm", saveToRealm)
        /*
         data CoinRealmModel {
             id = 65e0b314dd97ec12c15af07e;
             name = WhiteBIT Coin;
             favorites = 0;
         }
         */
        
        // 실제 Realm에 저장되어있는 data
        let realmDatas = repository.readItemName(item: coinInfoAPIResultList[sender.tag].name)
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
            print("data", data)
            repository.deleteItem(item: data)
            /*
             data CoinRealmModel {
                 id = 65e0ad3a6a116db69771a768;
                 name = Whiteheart;
                 favorites = 0;
             }
             */
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
