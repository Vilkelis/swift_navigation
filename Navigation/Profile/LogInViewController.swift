//
//  LogInViewController.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 21.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView =  {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoVk")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let loginTextField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.borderStyle = .roundedRect
        field.textColor = .black
        field.tintColor = UIColor(named: "colorVk")
        field.backgroundColor = .systemGray6
        
        field.layer.masksToBounds = true
        field.placeholder = "Email or phone"
        field.autocorrectionType = .no
        
        field.roundCornersWithRadius(10, top: true, bottom: false, shadowEnabled: false)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.borderStyle = .roundedRect
        field.textColor = .black
        field.tintColor = UIColor(named: "colorVk")
        field.backgroundColor = .systemGray6
        
        field.layer.masksToBounds = true
        field.placeholder = "Password"
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        
        field.roundCornersWithRadius(10, top: false, bottom: true, shadowEnabled: false)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.roundCornersWithRadius(10, shadowEnabled: false)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [logoImage, loginTextField, passwordTextField, loginButton].forEach {
            containerView.addSubview($0)
        }
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            logoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: -0.5),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func loginButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // type storyboard name instead of Main
        if let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewControllerID") as? ProfileViewController {
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

// MARK: - Extensions
extension UIView {
    
    /// Method adds shadow and corner radius for top of view by default.
    ///
    /// - Parameters:
    ///   - top: Top corners
    ///   - bottom: Bottom corners
    ///   - radius: Corner radius
    func roundCornersWithRadius(_ radius: CGFloat, top: Bool? = true, bottom: Bool? = true, shadowEnabled: Bool = true) {
        var maskedCorners = CACornerMask()
        
        if shadowEnabled {
            clipsToBounds = true
            layer.masksToBounds = false
            layer.shadowOpacity = 0.5
            layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        switch (top, bottom) {
        case (true, false):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case (false, true):
            maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case (true, true):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            break
        }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
