//
//  NewsData.swift
//  POC1
//
//  Created by Satvik Subramanian on 17/01/23.
//

import UIKit

class NewsData: NSObject, Codable {

    var id: String?
    var title: String?
    var newsDescription: String?
    var bannerUrl: String?
    var timeCreated: Double?
    var rank: Int = -1
    
    public func printableNewsData() -> String
    {
        return "id: \(id ?? ""), title:\(title ?? ""), newsDescription: \(newsDescription ?? "") ,bannerURLString:\(bannerUrl ?? ""), timeCreated: \(timeCreated ?? 0), rank: \(rank)"
    }
}

extension NewsData {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case newsDescription = "description"
        case bannerUrl = "banner_url"
        case timeCreated = "time_created"
    }
}
