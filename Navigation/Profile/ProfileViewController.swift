//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 12.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, ImageViewZoomableDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
            tableView.backgroundColor = UIColor(named: "appSystemGray6")
        }
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PostTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: PostTableHeaderView.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Posts"
    }
    
    //MARK: Profile Image Zoom
    var startFrame: CGRect?
    var backgroudView: UIView?
    var buttonImageZoomOut: UIButton?
    var startImage: UIImageView?
    var zoomImage: UIImageView?
    var imageProportionCoef: CGFloat = 0.0
    
    func performZoomInImageView(_ imageView: UIImageView) {
        startImage = imageView
        startImage?.isHidden = true
        startFrame = imageView.superview?.convert(imageView.frame, to: nil)
        imageProportionCoef = startFrame!.height / startFrame!.width
        
        zoomImage = UIImageView()
        zoomImage!.frame = startFrame!
        zoomImage!.image = imageView.image
        zoomImage!.layer.borderWidth = 3
        zoomImage!.layer.borderColor = UIColor.white.cgColor
        zoomImage!.clipsToBounds = true
        zoomImage!.layer.cornerRadius = zoomImage!.frame.height / 2
        zoomImage!.isUserInteractionEnabled = true
        
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            backgroudView = UIView() //frame: keyWindow.frame
            backgroudView?.backgroundColor = .gray
            backgroudView?.alpha = 0
            backgroudView?.translatesAutoresizingMaskIntoConstraints =  false
            
            let buttonSize = 50
            buttonImageZoomOut = UIButton()
            if #available(iOS 13.0, *) {
                let fontConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: CGFloat(buttonSize), weight: .bold))
                buttonImageZoomOut!.setImage(UIImage(systemName: "multiply", withConfiguration: fontConfig) , for: .normal)
                buttonImageZoomOut!.setImage(UIImage(systemName: "multiply", withConfiguration: fontConfig) , for: .focused)
                buttonImageZoomOut!.setImage(UIImage(systemName: "multiply", withConfiguration: fontConfig) , for: .highlighted)
            } else {
                // Fallback on earlier versions
                buttonImageZoomOut!.titleLabel?.font = .systemFont(ofSize: CGFloat(buttonSize))
                buttonImageZoomOut!.setImage(UIImage(named: "appMultiply") , for: .normal)
                buttonImageZoomOut!.setImage(UIImage(named: "appMultiply") , for: .focused)
                buttonImageZoomOut!.setImage(UIImage(named: "appMultiply") , for: .highlighted)
            }
 
            buttonImageZoomOut!.tintColor = .white
            buttonImageZoomOut!.translatesAutoresizingMaskIntoConstraints = false
            buttonImageZoomOut!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOutImageView)))
            buttonImageZoomOut!.alpha = 0
            
            keyWindow.addSubview(backgroudView!)
            keyWindow.addSubview(zoomImage!)
            keyWindow.addSubview(buttonImageZoomOut!)
            
            backgroudView!.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(keyWindow)
            }
            
            buttonImageZoomOut!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(keyWindow).offset(10)
                make.trailing.equalTo(keyWindow).offset(-10)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backgroudView?.alpha = 0.8
                self.zoomImage!.frame = CGRect(x:0, y: 0 , width: keyWindow.frame.width, height: self.imageProportionCoef * keyWindow.frame.width )
                self.zoomImage!.center = keyWindow.center
                self.zoomImage!.layer.cornerRadius = self.zoomImage!.frame.height / 2
            }, completion: { _ in
                self.zoomImage!.translatesAutoresizingMaskIntoConstraints = false
                self.zoomImage!.snp.makeConstraints { (make) -> Void in
                    make.width.equalTo(keyWindow)
                    make.height.equalTo(keyWindow.snp_width).multipliedBy(self.imageProportionCoef)
                    make.centerY.equalTo(keyWindow)
                    make.centerX.equalTo(keyWindow)
                }
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.buttonImageZoomOut!.alpha = 1
                }, completion: nil)
            })
            
        }
    }
    
    @objc func handleZoomOutImageView( _ tapGesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.buttonImageZoomOut!.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.zoomImage!.translatesAutoresizingMaskIntoConstraints = true
                self.zoomImage!.frame = self.startFrame!
                self.zoomImage!.layer.cornerRadius = self.zoomImage!.frame.height / 2
                self.backgroudView?.alpha = 0
            }, completion: {_ in
                self.backgroudView?.removeFromSuperview()
                self.buttonImageZoomOut?.removeFromSuperview()
                self.zoomImage?.removeFromSuperview()
                self.startImage?.isHidden = false
            })
        })
    }
    
    override func viewDidLayoutSubviews() {
        //Пересчитываем радиус углов у увеличенного изображения так как его пропорции при повороте экрана могли измениться
        if let image  =  self.zoomImage {
            image.layer.cornerRadius = image.frame.height / 2
        }
        //Пересчитываем стартовый фрейм, так как при изменении поворота экрана он мог измениться
        if let image = self.startImage {
            self.startFrame = image.superview?.convert(image.frame, to: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Storage.tableModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return Storage.tableModel[section - 1].posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: PhotosTableViewCell.self),
                for: indexPath) as! PhotosTableViewCell
            cell.toCatalogButton.addTarget(self, action: #selector(toCatalogButtonTouch), for: .touchUpInside)
            cell.catalog = Storage.catalogModel
            return cell
        }  else {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: PostTableViewCell.self),
                for: indexPath) as! PostTableViewCell
            
            cell.post = Storage.tableModel[indexPath.section - 1].posts[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: PostTableHeaderView.self)) as! PostTableHeaderView
            headerView.profileHeaderView.delegate = self
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    @objc private func toCatalogButtonTouch() {
        self.title = "Back"
        navigationController?.pushViewController(PhotosCollectionViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return  .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 8
        } else {
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            toCatalogButtonTouch()
        }
    }
}


