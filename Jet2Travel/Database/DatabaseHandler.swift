//
//  DatabaseHandler.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 07/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHandler: NSObject {
    static let shared = DatabaseHandler()
    let kArticleEntity = "Articles"
    let kUserEntity = "User"
    let kMedia = "Media"
    
    private override init() {}
    
    func saveArticles(article:ViewModelArticle){
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
            if let articleEntity = NSEntityDescription.entity(forEntityName: self.kArticleEntity, in: managedContext) {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.kArticleEntity)
            fetchRequest.predicate = NSPredicate(format: "id == %@", article.id ?? "")
            
            do {
                if let list = try managedContext.fetch(fetchRequest) as? [NSManagedObject], list.count > 0 {
                    return
                }
            
            let object = NSManagedObject(entity: articleEntity, insertInto: managedContext)
            object.setValue(article.id, forKey: "id")
            object.setValue(article.createdAt, forKey: "createdAt")
            object.setValue(article.comments, forKey: "comments")
            object.setValue(article.likes, forKey: "likes")
            object.setValue(article.content, forKey: "content")
           
                try managedContext.save()
                if let id = article.id, let users = article.user {
                    self.saveUsers(articleId: id, users: users)
                    if let media = article.media {
                        self.saveMedia(articleId: id, medias: media)
                    }
                }
            } catch {
            }
        }
        }
        
    }
    
    func saveUsers(articleId:String, users : [ViewModelUser]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let userEntity = NSEntityDescription.entity(forEntityName: kUserEntity, in: managedContext) {
            for user in users {
                let object = NSManagedObject(entity: userEntity, insertInto: managedContext)
                object.setValue(user.id, forKey: "id")
                object.setValue(user.createdAt, forKey: "createdAt")
                object.setValue(user.blogId, forKey: "blogId")
                object.setValue(user.name, forKey: "name")
                object.setValue(user.avatar, forKey: "avatar")
                
                object.setValue(user.lastname, forKey: "lastname")
                object.setValue(user.city, forKey: "city")
                object.setValue(user.designation, forKey: "designation")
                object.setValue(user.about, forKey: "about")
                object.setValue(articleId, forKey: "articleId") // FOREIGN KEY
            }
            do {
                try managedContext.save()
            } catch {
            }
        }
    }
    
    func saveMedia(articleId:String, medias : [ViewModelMedia]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let mediaEntity = NSEntityDescription.entity(forEntityName: kMedia, in: managedContext) {
            for media in medias {
                let object = NSManagedObject(entity: mediaEntity, insertInto: managedContext)
                object.setValue(media.id, forKey: "id")
                object.setValue(media.createdAt, forKey: "createdAt")
                object.setValue(media.blogId, forKey: "blogId")
                object.setValue(media.image, forKey: "image")
                object.setValue(media.title, forKey: "title")
                object.setValue(media.url, forKey: "url")
                object.setValue(articleId, forKey: "articleId") // FOREIGN KEY
          }
            do {
                try managedContext.save()
            } catch {
            }
        }
    }
    
    func fetchArticles()->([ViewModelArticle]?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: kArticleEntity)
        
        var list = [ViewModelArticle]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let article = ViewModelArticle()
                article.id = data.value(forKey: "id") as? String
                article.comments = data.value(forKey: "comments") as? Int
                article.createdAt = data.value(forKey: "createdAt") as? String
                article.content = data.value(forKey: "content") as? String
                article.likes = data.value(forKey: "likes") as? Int
                article.media = fetchMedia(articleId: data.value(forKey: "id")! as! String)
                article.user = fetchUser(articleId: data.value(forKey: "id")! as! String)
                list.append(article)
            }
        } catch {
            print ("fetch task failed", error)
        }
        return list
    }
    
    func fetchUser(articleId:String)->([ViewModelUser]?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        var list = [ViewModelUser]()
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:kUserEntity)
            fetchRequest.predicate = NSPredicate(format: "articleId == %@", articleId)
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for data in fetchedResults {
                let user = ViewModelUser()
                user.id = data.value(forKey: "id") as? String
                user.about = data.value(forKey: "about") as? String
                user.avatar = data.value(forKey: "avatar") as? String
                user.blogId = data.value(forKey: "blogId") as? String
                user.city = data.value(forKey: "city") as? String
                user.createdAt = data.value(forKey: "createdAt") as? String
                user.designation = data.value(forKey: "designation") as? String
                user.name = data.value(forKey: "name") as? String
                user.lastname = data.value(forKey: "lastname") as? String
                
                list.append(user)
           }
        }
        catch {
            print ("fetch task failed", error)
        }
        return list
    }
    
    func fetchMedia(articleId:String)->([ViewModelMedia]?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        var list = [ViewModelMedia]()
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:kMedia)
            fetchRequest.predicate = NSPredicate(format: "articleId == %@", articleId)
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for data in fetchedResults {
                let media = ViewModelMedia()
                media.id = data.value(forKey: "id") as? String
                media.blogId = data.value(forKey: "blogId") as? String
                media.createdAt = data.value(forKey: "createdAt") as? String
                media.title = data.value(forKey: "title") as? String
                media.image = data.value(forKey: "image") as? String
                media.url = data.value(forKey: "url") as? String
                list.append(media)
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return list
    }
}
