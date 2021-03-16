//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 29.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
 
    var catalog: [catalogImage]? {
        didSet {
            for (index, image) in stackView.arrangedSubviews.enumerated() {
                (image as! UIImageView).image = UIImage(named: catalog?[index].image ?? "logoVk")
            }
        }
    }
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func createImageView(imageName: String?) -> UIImageView {
       let image = UIImageView()
       image.image = UIImage(named: imageName ?? "logoVk")
       image.translatesAutoresizingMaskIntoConstraints = false
       image.clipsToBounds = true
       image.layer.cornerRadius = 6
       image.contentMode = .scaleAspectFill
       return image
    }
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        return label
    }()
    
    let toCatalogButton: UIButton = {
        let button = UIButton()
        let fontConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24))
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: fontConfig) , for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false       
        return button
    } ()
    
    // MARK: - Initializators
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        for _ in 0...3 {
            let image = createImageView(imageName: "")
            stackView.addArrangedSubview(image)
            
            image.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/4, constant: -8*3/4).isActive = true
            image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        }
    
        [titleLabel, toCatalogButton, stackView].forEach {
            self.contentView.addSubview($0)
        }
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            toCatalogButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            toCatalogButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
  
