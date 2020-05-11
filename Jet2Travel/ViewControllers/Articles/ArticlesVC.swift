//
//  ArticlesVC.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import UIKit

class ArticlesVC: UIViewController {
    
    @IBOutlet weak var articleTable: UITableView!
    let kArticleIdentifier = "ArticleCell"
    var articleList = [ViewModelArticle]()
    var cellHeights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        if (Helper.shared.isConnectedToNetwork()){
            self.getArticles()
        }else{
            if let list = DatabaseHandler.shared.fetchArticles() {
                articleList = list
                self.articleTable.dataSource = self
                self.articleTable.delegate = self
                articleTable.reloadData()
            }
        }
    }
    
    func configureView(){
        self.title = "Articles"
        articleTable.register(UINib(nibName: kArticleIdentifier, bundle: nil), forCellReuseIdentifier: kArticleIdentifier)
        articleTable.rowHeight = UITableView.automaticDimension
        
    }
    
    func getArticles(){
        ServiceHelper.shared.getArticleList(handler: self) { (modelArticleList, error) in
            
            if let list = modelArticleList {
                self.articleList.removeAll()
                for article in list {
                    self.articleList.append(ViewModelArticle(article: article))
                }
            DispatchQueue.main.async{
                self.articleTable.dataSource = self
                self.articleTable.delegate = self
                self.articleTable.reloadData()
            }
            }
            
            for article in self.articleList {
                DatabaseHandler.shared.saveArticles(article: article)
            }
        }
    }
}

extension ArticlesVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kArticleIdentifier, for: indexPath) as! ArticleCell
        cell.updateContent(article: articleList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
