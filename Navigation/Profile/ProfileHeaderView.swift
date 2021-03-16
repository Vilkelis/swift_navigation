//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 12.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

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
        self.backgroundColor = .systemGray6
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
        let constraints = [
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            statusLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -18-14),
            statusLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            statusLabel.heightAnchor.constraint(equalToConstant: 14),
            statusField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: padding),
            statusField.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding),
            statusField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusField.heightAnchor.constraint(equalToConstant: 40),
            showStatusButton.topAnchor.constraint(equalTo: statusField.bottomAnchor, constant: padding),
            showStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            showStatusButton.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.bottomAnchor.constraint(equalTo: showStatusButton.bottomAnchor, constant: padding)
        ]
        NSLayoutConstraint.activate(constraints)
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
