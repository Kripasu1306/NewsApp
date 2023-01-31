//
//  TopHeadLines.swift
//  POC1
//
//  Created by Satvik Subramanian on 28/01/23.
//

import UIKit

class Source: NSObject, Codable {
    var id: String?
    var name: String?
    
    func printableSource() {
        print("id: \(id ?? "") name: \(name ?? "")")
    }
}

class Article: NSObject, Codable {
    var source: Source?
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage:String?
    var publishedAt: String?
    var content: String?
    
    func printableArticle() {
        
        source!.printableSource()
        print("author: \(author ?? "") title: \(title ?? "") articleDescription: \(articleDescription ?? "") url: \(url ?? "") urlToImage: \(urlToImage ?? "") publishedAt: \(publishedAt ?? "") content: \(content ?? "")")
    }
}

extension Article {
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

class TopHeadLines: NSObject, Codable {
    
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
    func printTopHeadLinesAsObject()
    {
        print("status: \(status ?? "") totalResult: \(totalResults ?? 0)")
        
        guard let articles = articles else { return }
        for article in articles {
            article.printableArticle()
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articles = try container.decodeIfPresent([Article].self, forKey: .articles)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}

extension TopHeadLines {
    
    enum TopCodingKey: String, CodingKey {
        case status = "status"
        case totalResults
        case articles
    }
}
