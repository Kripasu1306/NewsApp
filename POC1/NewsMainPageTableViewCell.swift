//
//  NewsMainPageTableViewCell.swift
//  POC1
//
//  Created by Satvik Subramanian on 24/01/23.
//

import UIKit
import SDWebImage

class NewsMainPageTableViewCell: UITableViewCell {

    static let cellIdentifier = "NewsMainPageTableViewCell"
    let dateFormatter = DateFormatter()
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    func loadCellWithData(data: NewsData)
    {
        if let urlString = data.bannerUrl,
           let url = URL(string: urlString)
        {
            self.newsImage.sd_setImage(with: url)
        }
        titleLabel.text = data.title
        descriptionLabel.text = data.newsDescription
        if let timeCreated = data.timeCreated
        {
            let dataDate = Date(timeIntervalSince1970: timeCreated)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateAndTimeLabel.text = dateFormatter.string(from: dataDate)
        }
    }
}
