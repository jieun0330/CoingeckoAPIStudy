//
//  SearchTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit

class SearchTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [icon].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
//            $0.leading.top.
        }
    }
    
    override func configureView() {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
