//
//  ContentTableViewCell.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    static let identifier: String = "ContentTableViewCell"
    var id : UILabel = UILabel()
    var type: UILabel = UILabel()
    var date: UILabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(id)
        contentView.addSubview(type)
        contentView.addSubview(date)
        self.configureViews()
    }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

  override func layoutIfNeeded() {
     id.snp.makeConstraints {
             $0.left.equalToSuperview().offset(10)
             $0.right.equalToSuperview().offset(-10)
             $0.top.equalToSuperview().offset(5)
             $0.height.equalTo(30)
         }
       type.snp.makeConstraints {
          $0.left.equalToSuperview().offset(10)
          $0.top.equalTo(id.snp.bottom).offset(5)
          $0.height.equalTo(30)
          $0.width.equalTo(100)
        }
        date.snp.makeConstraints {
          $0.right.equalToSuperview().offset(-10)
          $0.top.equalTo(id.snp.bottom).offset(5)
          $0.height.equalTo(30)
          $0.width.equalTo(self.contentView.snp.width).multipliedBy(0.5)
        }
     }
    
    func configureViews(){
        date.textAlignment = NSTextAlignment.right
        id.font = UIFont.boldSystemFont(ofSize: 15)
        date.font = UIFont.systemFont(ofSize: 13)
        
    }
}
