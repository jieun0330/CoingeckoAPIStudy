//
//  SearchTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {
    
    let icon = UIImageView().then { <#UIImageView#> in
        <#code#>
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
        <#code#>
    }
    
    override func configureView() {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
