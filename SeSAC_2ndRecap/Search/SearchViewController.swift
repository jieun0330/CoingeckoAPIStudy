//
//  SearchViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit

class SearchViewController: BaseViewController {

    let profileImage = UIImageView().then {
        $0.image = .tabUser
        $0.layer.borderColor = DesignSystemColor.purple.value.cgColor
        $0.layer.borderWidth = 2
    }
    
    let mainTitle = UILabel().then {
        $0.text = "Search"
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "코인명 검색"
        $0.backgroundImage = UIImage()
        $0.layer.cornerRadius = 10
    }
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [profileImage, mainTitle, searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(35)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
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
        view.backgroundColor = .white
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier)!
        
        return cell
    }
}
