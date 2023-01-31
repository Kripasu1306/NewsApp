//
//  ViewController.swift
//  POC1
//
//  Created by Satvik Subramanian on 17/01/23.
//

import UIKit

class ViewController: UIViewController {

    var newsData = [NewsData]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "NewsMainPageTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: NewsMainPageTableViewCell.cellIdentifier)
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        callApiToFetchArrayOfNewsAsResponse()
        callApiToFetchNestedNewsDataAsResponse()
    }
    
    func printAllTheNewsDataValues()
    {
        for (index, news) in newsData.enumerated() {
            print("newsIndex: \(index)      \(news.printableNewsData())")
        }
    }
    
    func callApiToFetchArrayOfNewsAsResponse() {
        
        NetworkHelper.fetchAllTheNewsData {[weak self] newsData, error in
            guard let self = self else { return }
            guard let newsData = newsData else {
                return
            }
            
            DispatchQueue.main.async {
                self.newsData = newsData
                self.printAllTheNewsDataValues()
                self.tableView.reloadData()
            }
            
        }
    }
    
    func callApiToFetchNestedNewsDataAsResponse()
    {
        NetworkHelper.fetchTopHeadLines (countryString: "in", completion: { topHeadLines, error in
            guard let topHeadLines = topHeadLines,
                  error == nil else {
                print("Response Errored")
                return }
            DispatchQueue.main.async {
                topHeadLines.printTopHeadLinesAsObject()
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsMainPageTableViewCell.cellIdentifier) as! NewsMainPageTableViewCell
        cell.loadCellWithData(data: newsData[indexPath.row])
        return cell
    }
}

