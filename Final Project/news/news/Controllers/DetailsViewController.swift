//
//  DetailsViewController.swift
//  news
//
//  Created by Admin on 7/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var readBtn: UIButton!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var readLaterBtn: UIButton!
    
    var selectedArticle: Article?
    
    var selectedColor: UIColor?
    
    var addedToReadLater = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let logoColor = selectedColor {
            logo.image = logo.image?.withRenderingMode(.alwaysTemplate)
            logo.tintColor = logoColor
            readBtn.backgroundColor = logoColor
        }
        
        articleTitle.text = selectedArticle?.title
        articleAuthor.text = "\(selectedArticle?.author == "" ? "Unknown Author" : (selectedArticle?.author ?? "Unknown Author"))"
        articleDate.text = selectedArticle?.date?.toFullDate()
        sourceName.text = selectedArticle?.source.name ?? "Unknown source"
        
        if selectedArticle?.description != "" && (selectedArticle?.description ?? "").count > (selectedArticle?.content ?? "").count {
            articleDescription.text = selectedArticle?.description
        } else  {
            
            articleDescription.text = selectedArticle?.content?.replacingOccurrences(of: "\\[[+\\w\\s]*\\]", with: "", options: .regularExpression).replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "")
            
        }
        
        articleAuthor.textColor = Constants.grayText
        articleDate.textColor = Constants.lightGrayText
        
        readBtn.rounded()
        
        articlePhoto.image = UIImage(named: "img-placeholder")
        if let photo = selectedArticle?.image {
            photo.downloadImage { (img) in
                DispatchQueue.main.async {
                    self.articlePhoto.image = img
                }
            }
        } else {
            articlePhoto.image = UIImage(named: "img-placeholder")
        }
        
        
        CoreDataManager.addRecentArticle(article: selectedArticle!)
        
        
        
        if CoreDataManager.fetchReadLater().contains(where: { $0.url == selectedArticle!.url }) {
            readLaterBtn.setImage(UIImage(named: "save.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            readLaterBtn.imageView?.tintColor = Constants.purple
            addedToReadLater = true
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("update_saved"), object: nil)
        
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onReadLater(_ sender: UIButton) {
        if !addedToReadLater {
            CoreDataManager.addReadLaterArticle(article: selectedArticle!)
            
            UIView.animate(withDuration: 0.15, animations: {
                sender.setImage(UIImage(named: "save.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                sender.imageView?.tintColor = Constants.purple
                sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { (f) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                    
                    sender.transform = .identity
                }) { (f) in
                    
                }
            }
        } else {
            
            CoreDataManager.removeReadLater(article: CoreDataManager.fetchReadLater().filter { $0.url == selectedArticle?.url }[0])
            
            UIView.animate(withDuration: 0.15, animations: {
                sender.setImage(UIImage(named: "save")?.withRenderingMode(.alwaysTemplate), for: .normal)
                sender.imageView?.tintColor = UIColor.black
                sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }) { (f) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                    
                    sender.transform = .identity
                }) { (f) in
                    
                }
            }
        }
        
        addedToReadLater = !addedToReadLater
        NotificationCenter.default.post(name: NSNotification.Name("update_saved"), object: nil)
    }
    
    @IBAction func onRead(_ sender: UIButton) {
        
        let url = URL(string: selectedArticle!.url!)
        
        let safari = SFSafariViewController(url: url!)
        safari.modalPresentationStyle = .popover
        present(safari, animated: true, completion: nil)
    }
    
    @IBAction func onCopy(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = selectedArticle?.url
        
        UIView.animate(withDuration: 0.15, animations: {
            sender.setImage(UIImage(named: "done")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = UIColor(red: 0/255, green: 223/255, blue: 130/255, alpha: 1)
            sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (f) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                
                sender.transform = .identity
            }) { (f) in
                
            }
        }
    }
    
}
