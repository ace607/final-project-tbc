//
//  TopNewsContainerTableViewCell.swift
//  news
//
//  Created by Admin on 7/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class TopNewsContainerTableViewCell: UITableViewCell {
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var topNewsCollection: UICollectionView!
    
    var didSelectItemAction: ((Article) -> Void)?
    
    var articles: [Article]! {
        didSet {
            topNewsCollection.reloadData()
        }
    }
    
    static let identifier = "top_news_container_cell"
    
    private var isLoading = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topNewsCollection.delegate = self
        topNewsCollection.dataSource = self
        topNewsCollection.showsHorizontalScrollIndicator = false
        
        
        topNewsCollection.register(UINib(nibName: "TopNewsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "top_news_cell")
        
        
        //https://github.com/ink-spot/UPCarouselFlowLayout
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 100, height: topNewsCollection.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.5
        flowLayout.spacingMode = .fixed(spacing: 0)
        topNewsCollection.collectionViewLayout = flowLayout
        
//        self.contentView.frame = self.contentView.frame.insetBy(
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onPrevious(_ sender: UIButton) {
        let collectionBounds = self.topNewsCollection.bounds
        let contentOffset = CGFloat(floor(self.topNewsCollection.contentOffset.x - collectionBounds.size.width + 95))
        self.moveToFrame(contentOffset: contentOffset)
    }
    @IBAction func onNext(_ sender: UIButton) {
        let collectionBounds = self.topNewsCollection.bounds
        let contentOffset = CGFloat(floor(self.topNewsCollection.contentOffset.x + collectionBounds.size.width - 95))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.topNewsCollection.contentOffset.y ,width : self.topNewsCollection.frame.width,height : self.topNewsCollection.frame.height)
        self.topNewsCollection.scrollRectToVisible(frame, animated: true)
    }

    
}

extension TopNewsContainerTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(articles[indexPath.row])
    }
}

extension TopNewsContainerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles != nil ? articles.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topNewsCollection.dequeueReusableCell(withReuseIdentifier: "top_news_cell", for: indexPath) as! TopNewsCollectionViewCell
        
        
        cell.isLoading(isLoading)
        if articles.count > 10 {
            
            cell.configure(photo: articles[indexPath.row].image!, title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!, date: articles[indexPath.row].date!) {
                cell.isLoading(false)
            }
        }
        
        
        return cell
    }
    
    
    
}

extension TopNewsContainerTableViewCell: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

