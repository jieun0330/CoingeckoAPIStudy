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
    var coinInfoAPIResultList: [InfoAPI] = []
//    var coinPriceAPIResultList: PriceAPI = []
    
    let repository = CoinRepository()
    // 3. 처음에는
    // var realmList: Results<CoinRealmModel>!
    // 로 하려했는데 초기화를 안해줘서 문제가 생김
    // realmList에 초기화를 하기 위해서 작성하게 된게
    
    
    // 그럼 이전에 Results<CoinRealmModel>! 이렇게 작업했던거는??
    // 추측: CoinRealmModel의 개수가 필요할때는 Results가 필요한데 지금은 favorites의 true, false 여부인 친구들만 알면 되니까 배열?
    // Results<CoinRealmModel>에서도 충분히 가져올 수 있는거 아닌가?
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
    }
    
    lazy var tableView = UITableView().then {
        $0.backgroundColor = DesignSystemColor.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.rowHeight = 60
        $0.separatorStyle = .none
    }
//    {
//        didSet {
//            tableView.reloadData()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputViewDidLoadTrigger.value = ()
        
//        viewModel.outputList.bind { data in
//            self.realmList = data
//            self.tableView.reloadData()
//        }
        
        // 검색결과 API 호출
        viewModel.outputCoinInfoData.bind { data in
            self.coinInfoAPIResultList = data
            self.tableView.reloadData()
        }
        
//        viewModel.outputCoinPriceData.bind { data in
//            self.coinPriceAPIResultList = data
//
//        }
        
//        viewModel.outputCoinPriceData.bind { data in
//            self.coinPriceAPIResultList = data
//        }
        
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
        
        // 1. cell의 favorite이 true, false 여부로 -> 이미지를 다르게 세팅하고싶음
        // 2. 그러면 CoinRealmModel의 favorites의 true, false 여부를 받아와야함
        
        if repository.itemFilter(item: row.name).first?.name == row.name {
            cell.favorites.setImage(.btnStarFill, for: .normal)
        } else {
            cell.favorites.setImage(.btnStar, for: .normal)
        }
//        
  
        
//        cell.favorites.setImage(.btnStar, for: .normal)
        cell.favorites.addTarget(self, action: #selector(favoritesButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        let coinInfo = coinInfoAPIResultList[indexPath.row]
//        let coinPrice = coinPriceAPIResultList
        

        
        vc.name.text = coinInfo.name
        vc.icon.kf.setImage(with: URL(string: coinInfo.large))
        viewModel.inputDidSelectRow.value = coinInfo.id
//        vc.price.text = "여기"
        
        
//        vc.price.text = coinPrice[0].id
//        print("coinPrice", coinPrice)
        
//        print("1", coinInfo.id)
//        print("여기에도 보여야될텐데", coinPriceAPIResultList)
        
//        APIManager.shared.fetchCoinPriceAPI()
        
//        print("coinInfo.name", coinInfo.name) // 1.
//        print("coinInfo.id", coinInfo.id) // 1.
        
        
        
        
//        vc.price.text = "\(vc.coinPriceAPIResult[indexPath.row].currentPrice)"
//            print(vc.coinPriceAPIResult[indexPath.row].currentPrice)
        
//        print("row.name", row.name)
//        coinPriceAPIResultList
        
    }
    
    @objc func favoritesButtonClicked(_ sender: UIButton) {
        
//        repository.createFavoriteItem(realmList)
        
//        if repository.itemFilter(item: apiResultList[sender.tag].name).first?.name != apiResultList[sender.tag].name {
//            
//        }
        
//        repository.updateFavoriteItem(item: realmList[sender.tag])
//        print("realmList", realmList[sender.tag])
        
//        tableView.reloadData()
        
//        if repository.itemFilter(item: apiResultList[sender.tag].name).first?.name == apiResultList[sender.tag].name {
//            print("눌린건가")
//            print(realmList[sender.tag])
//            realmList.remove(at: sender.tag)
//            tableView.reloadData()
//        } else {
//            repository.createFavoriteItem(name: apiResultList[sender.tag].name) // 저장하면서 false로 저장되니까
//            self.view.makeToast("즐겨찾기에 추가되었습니다") // toast
//            tableView.reloadData()
//        }

    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else { return }
        viewModel.inputSearchBarTapped.value = searchBarText
        
        
//        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        tableView.
    }
}
