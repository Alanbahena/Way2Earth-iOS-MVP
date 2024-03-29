//
//  ProfileHeader.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/25/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import SDWebImage

let profileHeaderIdentifier = "ProfileCell"

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
    func header( _profileHeader: ProfileHeader, didTapSettingsButton user: User)
}

class ProfileHeader: UICollectionReusableView {
 
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    var profileBackgroundImage: UIImageView = {
        let profileBI = UIImageView()
        profileBI.backgroundColor = .lightGray
        profileBI.contentMode = .scaleToFill
        profileBI.image = #imageLiteral(resourceName: "profileBackground")
        return profileBI
    }()
    
    private let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .lightGray
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        return profileImage
    }()
    
    private let profileNameLabel: UILabel = {
        let profileNameLabel = UILabel()
        profileNameLabel.font = UIFont.robotoBold(size: 20)
        profileNameLabel.sizeToFit()
        profileNameLabel.numberOfLines = 1
        profileNameLabel.textColor = .white
        profileNameLabel.textAlignment = .center
        return profileNameLabel
    }()
    
    private var userNameLabel: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.RobotoRegular(size: 13)
        userName.sizeToFit()
        userName.numberOfLines = 1
        userName.textColor = .white
        userName.textAlignment = .center
        return userName
    }()
    
    private var descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.RobotoRegular(size: 13)
        dl.sizeToFit()
        dl.numberOfLines = 0
        dl.textColor = .white
        dl.textAlignment = .center
        return dl
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .init(white: 1, alpha: 0.7)
        button.titleLabel?.font = UIFont.robotoBold(size: 11)
        button.setTitleColor(.spaceColor, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
   
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "SettingsProfile"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSettingsProfile), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .systemPink
        
        //profileBackgroundImage
        addSubview(profileBackgroundImage)
        profileBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        profileBackgroundImage.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        profileBackgroundImage.setHeight(150)
        
        //profileImageView
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        profileImageView.centerX(inView: profileBackgroundImage)
        profileImageView.anchor(top: topAnchor, paddingTop: 100)
        
        //profileUserTexts
        let UserStack = UIStackView(arrangedSubviews: [profileNameLabel, userNameLabel])
        UserStack.axis = .vertical
        UserStack.distribution = .fillProportionally
        addSubview(UserStack)
        UserStack.centerX(inView: profileBackgroundImage)
        UserStack.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)
 
        //DescriptionLabel
        addSubview(descriptionLabel)
        descriptionLabel.centerX(inView: profileBackgroundImage)
        descriptionLabel.anchor(top: UserStack.bottomAnchor, paddingTop: 15)
        descriptionLabel.setWidth(200)
        
        //EditFollowButton
        addSubview(editProfileButton)
        editProfileButton.setDimensions(height: 25, width: 76)
        editProfileButton.anchor(top: profileBackgroundImage.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 15)
        
        //Followers/Posts/Following
        let stackFollowers = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stackFollowers.distribution = .fillEqually
        
        //StackFollowers
        addSubview(stackFollowers)
        stackFollowers.centerX(inView: profileImageView)
        stackFollowers.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10 , paddingLeft: 25, paddingRight: 25)
        
        //SettingsButton
        addSubview(settingsButton)
        settingsButton.anchor(top: profileBackgroundImage.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 15)
        settingsButton.setDimensions(height: 23, width: 23)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleSettingsProfile() {
        guard let viewModel = viewModel else { return }
        delegate?.header(_profileHeader: self, didTapSettingsButton: viewModel.user)
    }
    
    @objc func handleEditProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let  viewModel = viewModel else { return }
        profileNameLabel.text = viewModel.profileNameLabel
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        userNameLabel.text = viewModel.userName
        descriptionLabel.text = "A person who loves to travel. The sky is not the limit"
        
        editProfileButton.setTitle(viewModel.followButtontext, for: .normal)
        editProfileButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        postLabel.attributedText = viewModel.numberOfPosts
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
    }
}
