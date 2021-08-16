//
//  APITableViewCell.swift
//  Comcast
//
//  Created by Zion Calvo on 8/16/21.
//

import UIKit

class APITableViewCell: UITableViewCell {
    
    static let identifier = "APITableViewCell"
    
    let apiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(apiLabel)
        addSubview(descriptionLabel)
        addSubview(linkLabel)
        
        addConstraints()
        
    }
    
    func setUpCell(api: API) {
        apiLabel.text = api.API
        descriptionLabel.text = api.Description
        linkLabel.text = api.Link
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
        
            apiLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            apiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: apiLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            linkLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
