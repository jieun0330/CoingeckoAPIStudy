//
//  ChartViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit

class ChartViewController: BaseViewController {
    
    lazy var rightFavoriteButton = UIBarButtonItem(image: .btnStar,
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(rightFavoriteButtonClicked)).then { _ in
        
    }
    
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    let name = UILabel().then {
        $0.font = DesignSystemFont.main.font
        $0.text = "Solona"
    }
    
    let price = UILabel().then {
        $0.text = "$69,234,245"
        $0.font = DesignSystemFont.main.font
    }
    
    let percentage = UILabel().then {
        $0.text = "+3.22%"
        $0.textColor = .red
        $0.font = DesignSystemFont.percentage.font
    }
    
    let today = UILabel().then {
        $0.text = "Today"
        $0.font = DesignSystemFont.percentage.font
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [icon, name, price, percentage, today].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(10)
            $0.size.equalTo(35)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing)
            $0.top.equalTo(icon.snp.top)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        price.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.leading)
            $0.top.equalTo(icon.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        percentage.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.leading)
            $0.top.equalTo(price.snp.bottom).offset(10)
            $0.size.equalTo(30)
        }
        
        today.snp.makeConstraints {
            $0.top.equalTo(percentage.snp.top)
            $0.leading.equalTo(percentage.snp.trailing)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = ""
    }
    
    @objc func rightFavoriteButtonClicked() {
        
    }
    
}
