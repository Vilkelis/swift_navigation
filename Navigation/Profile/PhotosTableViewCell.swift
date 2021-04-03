//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 29.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

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
        button.titleLabel?.font = .systemFont(ofSize: 24)
        if #available(iOS 13.0, *) {
            let fontConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24))
            button.setImage(UIImage(systemName: "arrow.right", withConfiguration: fontConfig) , for: .normal)
        } else {
            // Fallback on earlier versions
            button.setImage(UIImage(named: "appArrowRight") , for: .normal)
       //     button.imageView?.contentMode = .scaleAspectFit
         //   button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
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
            
            image.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(stackView).multipliedBy(1/4).offset(-8*3/4)
                make.height.equalTo(image.snp_width)
            }
        }
        
        [titleLabel, toCatalogButton, stackView].forEach {
            self.contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(12)
        }
        toCatalogButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(contentView).offset(-12)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(12)
            make.leading.equalTo(contentView).offset(12)
            make.trailing.equalTo(contentView).offset(-12)
            make.bottom.equalTo(contentView).offset(-12)
        }
        
    }
}

