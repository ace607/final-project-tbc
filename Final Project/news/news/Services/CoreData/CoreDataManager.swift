//
//  CoreDataManager.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static var name = String()
    static var age = Int()
    static var email = String()
    static var selectedCountries = [(String, String)]()
    static var selectedCategories = [String]()
    static var keywords = [String]()
    static let context = AppDelegate.coreDataContainer.viewContext
    
    static private func createUser() {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(entity: entityDescription!, insertInto: context)
        
        user.name = name
        user.email = email
        user.age = Int16(age)

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't create user")
        }
    }
    
    static private func addCountry(selectedCountry: (String, String)) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Country", in: context)
        
        let country = Country(entity: entityDescription!, insertInto: context)
        
        country.id = selectedCountry.1
        country.name = selectedCountry.0

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't add countries")
        }
    }
    
    static private func addCategory(name: String) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: context)
        
        let category = Category(entity: entityDescription!, insertInto: context)
        
        category.name = name

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't add categories")
        }
    }
    
    static private func addKeyword(name: String) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Keyword", in: context)
        
        let keyword = Keyword(entity: entityDescription!, insertInto: context)
        
        keyword.name = name

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't add keywords")
        }
    }
    
    
    static func addReadLaterArticle(article: Article) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "ReadLaterArticle", in: context)
        
        let savedArticle = ReadLaterArticle(entity: entityDescription!, insertInto: context)
        
        savedArticle.author = article.author ?? "Unknown"
        savedArticle.title = article.title ?? "No Title"
        savedArticle.content = article.content ?? "No Content"
        savedArticle.desc = article.description ?? "No Description"
        savedArticle.date = article.date ?? "Unknown Date"
        savedArticle.img = article.image ?? "null"
        savedArticle.source = article.source.name ?? "Unknown source"
        savedArticle.url = article.url ?? "www.google.com"
        savedArticle.dateAdded = Date()
        

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't add to Read Later")
        }
    }
    
    
    static func addRecentArticle(article: Article) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "RecentArticle", in: context)
        
        let recentArticle = RecentArticle(entity: entityDescription!, insertInto: context)
        
        recentArticle.author = article.author ?? "Unknown"
        recentArticle.title = article.title ?? "No Title"
        recentArticle.content = article.content ?? "No Content"
        recentArticle.desc = article.description ?? "No Description"
        recentArticle.date = article.date ?? "Unknown Date"
        recentArticle.img = article.image ?? "null"
        recentArticle.source = article.source.name ?? "Unknown source"
        recentArticle.url = article.url ?? "www.google.com"
        recentArticle.dateAdded = Date()
        

        do {
            try context.save()
        } catch {
            print("ERROR: Couldn't add recent article")
        }
    }
    
    static func saveData() {
        self.createUser()
        
        self.selectedCountries.forEach { (item) in
            self.addCountry(selectedCountry: item)
        }
        
        self.selectedCategories.forEach { (name) in
            self.addCategory(name: name)
        }
        
        self.keywords.forEach { (name) in
            self.addKeyword(name: name)
        }
    }
    
    static func fetchUser() -> User {
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let users = result as [User]
            
            return users[0]
        } catch {
            print("ERROR: Couldn't fetch users")
        }
        
        return User()
    }
    
    static func fetchCategories() -> [Category] {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let categories = result as [Category]
            
            return categories
        } catch {
            print("ERROR: Couldn't fetch categories")
        }
        
        return []
    }
    
    static func fetchCountries() -> [Country] {
        
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let countries = result as [Country]
            
            return countries
        } catch {
            print("ERROR: Couldn't fetch countries")
        }
        
        return []
    }
    
    static func fetchKeywords() -> [Keyword] {
        
        let request: NSFetchRequest<Keyword> = Keyword.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let keywords = result as [Keyword]
            
            return keywords
        } catch {
            print("ERROR: Couldn't fetch keywords")
        }
        
        return []
    }
    
    static func fetchReadLater() -> [ReadLaterArticle] {
        
        let request: NSFetchRequest<ReadLaterArticle> = ReadLaterArticle.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let articles = result as [ReadLaterArticle]
            
            return ((articles as NSArray?) as! [ReadLaterArticle]).sorted(by: { ($0.dateAdded!).compare($1.dateAdded!) == .orderedDescending })
        } catch {
            print("ERROR: Couldn't fetch read later articles")
        }
        
        return []
    }
    
    
    static func fetchRecents() -> [RecentArticle] {
        
        let request: NSFetchRequest<RecentArticle> = RecentArticle.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let articles = result as [RecentArticle]
            
            return ((articles as NSArray?) as! [RecentArticle]).sorted(by: { ($0.dateAdded!).compare($1.dateAdded!) == .orderedDescending })
        } catch {
            print("ERROR: Couldn't fetch recent articles")
        }
        
        return []
    }
    
    static func removeReadLater(article: ReadLaterArticle) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(article)
        do {
            try context.save()
        } catch {
            
        }
    }
    
}
