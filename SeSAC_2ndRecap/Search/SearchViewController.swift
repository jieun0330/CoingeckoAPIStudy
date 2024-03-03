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
    
    let viewModel = ViewModel()
    let repository = RepositoryRealm()
    var coinInfoAPIResultList: [InfoAPI] = []
    var coinPriceAPIResultList: PriceAPI = []
    var coinID: String?
    
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
        /*[UIKeyboardTaskQueue lockWhenReadyForMainThread] timeout waiting for task on queue 뜨는 오류로
         키보드가 등장할 때 앱 동작에 문제가 발생,
         '수정 제안'이 등장할 때 문제가 있어서 '수정 제안' 자체를 숨기는 두가지 코드
         */
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
        viewModel.outputCoinInfoAPI.bind { data in
            self.coinInfoAPIResultList = data
            self.tableView.reloadData()
        }
        
        viewModel.outputCoinPriceAPI.bind { data in
            self.coinPriceAPIResultList = data
            
            if self.coinID != nil {
                let vc = ChartViewController()
                vc.data = self.coinPriceAPIResultList.first
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
        return viewModel.outputCoinInfoAPI.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let row = viewModel.outputCoinInfoAPI.value[indexPath.row]
        
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
        
        let coinPriceInfo = coinInfoAPIResultList[indexPath.row]
        self.coinID = coinPriceInfo.id
        
        viewModel.inputViewTrigger.value = coinPriceInfo.id
    }
    
    @objc func favoritesButtonClicked(_ sender: UIButton) {
        
        // 즐겨찾기 버튼을 눌렀을 때 해당 셀의 id를 램 형식에 맞게 저장해주기 위한 data
        let saveToRealm = CoinRealmModel(id: viewModel.outputCoinInfoAPI.value[sender.tag].id)
//        print("saveToRealm", saveToRealm)
        /* saveToRealm
         CoinRealmModel {
             id = tether-gold;
         }
         */
        
        // 실제 Realm에 저장되어있는 data
        let realmDatas = repository.readItemName(id: viewModel.outputCoinInfoAPI.value[sender.tag].id)
        
        if realmDatas.contains(where: { data in
            repository.deleteItem(item: data)
            return true
        }) {
            tableView.reloadData()
            print("중복")
            self.view.makeToast("즐겨찾기에서 삭제되었습니다")
        } else {
            
            
            if repository.fetchAllItem().count >= 10 {
                self.view.makeToast("즐겨찾기는 최대 10개까지 가능합니다")
            } else {
                tableView.reloadData()
                // repository에 저장하기
                repository.createFavoriteItem(saveToRealm)
                // toast 메세지 띄워주기
                self.view.makeToast("즐겨찾기에 추가되었습니다")
            }
            
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
