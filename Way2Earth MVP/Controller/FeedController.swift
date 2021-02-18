//
//  FeedController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//
import Foundation
import UIKit

protocol CustomDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class FeedController: UICollectionViewController {
    
    let items: [LayoutItem] = [
        LayoutItem(image: UIImage(named: "photo1")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago"),
        LayoutItem(image: UIImage(named: "photo2")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago"),
        LayoutItem(image: UIImage(named: "photo3")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago"),
        LayoutItem(image: UIImage(named: "photo1")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago"),
        LayoutItem(image: UIImage(named: "photo3")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago"),
        LayoutItem(image: UIImage(named: "photo1")!, titleText: "The Secrets I found in the mayan Culture", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago")
    ]
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
            layout.delegate = self 
        }
            
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 5)
        collectionView.backgroundColor = UIColor.spaceColor
    }
}

    //MARK: - CustomDelegate

extension FeedController: CustomDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        
        let image = items[indexPath.item].image
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        let tittleText = items[indexPath.item].titleText
        let font = UIFont.merriWeatherBold(size: 10)
        let titleTextHeight = tittleText.heightForWidth(width: withWidth, font: font)
        
        let userText = items[indexPath.item].userText
        let userTextFont = UIFont.openSansRegular(size: 8)
        let userTextHeight = userText.heightForWidth(width: withWidth, font: userTextFont)
        
        return FeedCell.annotationPadding * 2 + titleTextHeight + 2 + userTextHeight
    }
}

    //MARK: - UIColllectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellIdentifier, for: indexPath) as! FeedCell
        
        
        let item = items[indexPath.item]
        cell.imageView.image = item.image
        cell.titleTextLabel.text = item.titleText
        cell.profileImageView.image = item.profileImage
        cell.userText.text = item.userText
        cell.postTime.text = item.postTime
        
        return cell
    }
    
}
