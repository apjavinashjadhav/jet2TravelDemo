//
//  ArticleCell.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblArticleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    func setupCell(){
        imgProfilePic.layer.cornerRadius = imgProfilePic.bounds.width / 2.0
        imgProfilePic.clipsToBounds = true
    }
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            DispatchQueue.main.async {
                if oldValue != nil {
                    self.imgArticle.removeConstraint(oldValue!)
                }
                if self.aspectConstraint != nil {
                    self.imgArticle.addConstraint(self.aspectConstraint!)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func updateContent(article:ViewModelArticle){
        DispatchQueue.main.async {
            self.lblComments.text = "\(article.comments ?? 0) Comments"
            self.lblLikes.text = "\(article.likes ?? 0) Likes"
            self.lblArticleText.text = article.content ?? ""
            let date = article.createdAt?.dateFromString()
            self.lblDuration.text = date?.getElapsedInterval()
            if let user:ViewModelUser = article.user?[0] {
                self.lblUserName.text = "\(user.name ?? "") \(user.lastname ?? "")"
                self.lblUserDesignation.text = user.designation ?? ""
                if let avatar = user.avatar, let url = URL(string: avatar) {
                    Services.shared.getDataFromUrl(url: url) { (data, urlResponse, error) in
                        DispatchQueue.main.async {
                            self.imgProfilePic.image = UIImage(data: data!)
                        }
                    }
                }
            }
            
            
            if let media:ViewModelMedia = article.media?[0] {
                
                if let avatar = media.image, let url = URL(string: avatar) {
                    print(url)
                    Services.shared.getDataFromUrl(url: url) { (data, urlResponse, error) in
                        DispatchQueue.main.async {
                            let image = UIImage(data: data!)
                            let aspect = image!.size.width / image!.size.height

                            let constraint = NSLayoutConstraint(item: self.imgArticle, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.imgArticle, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
                            constraint.priority = UILayoutPriority(rawValue: 999)
                            self.aspectConstraint = constraint
                            self.imgArticle.image = image
                        }
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
