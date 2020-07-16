//
//  CategoryListContainerTableViewCell.swift
//  news
//
//  Created by Admin on 7/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CategoryListContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    let categories = Constants.categories
    let colors = Constants.categoryColors.shuffled()
    
    static let identifier = "category_list_container_cell"
    
    
    var didSelectCategoryAction: ((_ category: String,_ color: UIColor) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        categoriesCollection.showsHorizontalScrollIndicator = false
        
        categoriesCollection.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "category_list_cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CategoryListContainerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCategoryAction?(categories[indexPath.row], colors[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "category_list_cell", for: indexPath) as! CategoryListCollectionViewCell
        
        cell.categoryName.text = categories[indexPath.row].capitalized
        cell.categoryIcon.image = UIImage(named: "\(categories[indexPath.row])-icon")?.withRenderingMode(.alwaysTemplate)
        
        cell.categoryIcon.tintColor = UIColor.white
        
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
