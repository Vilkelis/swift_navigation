//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 12.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

protocol ImageViewZoomableDelegate {
    func performZoomInImageView(_ imageView: UIImageView)
}

class ProfileHeaderView: UIView {
    var statusText: String = "Waiting for something..."
    
    private lazy var imageAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    }()
        
    var delegate: ImageViewZoomableDelegate?
        
    private lazy var  image: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled =  true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnImage)))
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusField: UITextField = {
        let field = UITextField()
        field.addTarget(self, action: #selector(statusFieldChanged), for: .editingChanged)
        field.placeholder = "New status text"
        field.font = .systemFont(ofSize: 15, weight: .regular)
        field.borderStyle = .roundedRect
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 12
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showStatusButtonTapped), for: .touchUpInside)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.masksToBounds = false
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializators
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
            self.backgroundColor = UIColor(named: "appSystemGray6")
        }
        image.image = UIImage(named: "hipster_cat")
        titleLabel.text = "Hipster cat"
        statusLabel.text = self.statusText
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Subviews
    override func layoutSubviews(){
        super.layoutSubviews()
        image.layer.cornerRadius = image.frame.height / 2
    }
    
    func setupSubviews() {
        [titleLabel, statusLabel, statusField, showStatusButton, image].forEach {
            self.addSubview($0)
        }
        
        let padding: CGFloat = 16.0

        image.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(padding)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(padding)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(27)
            make.leading.equalTo(image.snp_trailing).offset(padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-padding)
            make.height.equalTo(18)
        }
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(image.snp_bottom).offset(-18-14)
            make.leading.equalTo(image.snp_trailing).offset(padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-padding)
            make.height.equalTo(14)
        }
        statusField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(statusLabel.snp_bottom).offset(padding)
            make.leading.equalTo(image.snp_trailing).offset(padding)
            make.trailing.equalTo(statusLabel)
            make.height.equalTo(40)
        }
        showStatusButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(statusField.snp_bottom).offset(padding)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(padding)
            make.trailing.equalTo(statusLabel)
            make.height.equalTo(50)
            make.bottom.equalTo(self).offset(-padding)
        }
        
    }
    
    //MARK: - Events
    @objc private func showStatusButtonTapped() {
        statusLabel.text = self.statusText
        print("Current status:", statusLabel.text ?? "empty")
    }
    
    @objc private func statusFieldChanged(_ textField: UITextField){
        statusText = textField.text ?? ""
    }
    
    //MARK: - Tap On Image
    @objc func handleTapOnImage() {
        delegate?.performZoomInImageView(image)
    }
}
