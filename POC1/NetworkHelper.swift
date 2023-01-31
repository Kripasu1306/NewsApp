//
//  NetworkHelper.swift
//  POC1
//
//  Created by Satvik Subramanian on 17/01/23.
//

import UIKit

class NetworkHelper: NSObject {
    
    //Array of objects
    static func fetchAllTheNewsData(completionBlock:@escaping((_ newsData:[NewsData]?, _ error: Error?) -> Void))
    {
        guard let url = URL(string: "https://storage.googleapis.com/carousell-interview-assets/android/carousell_news.json") else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in//Data. URLResponse, Error
            if error == nil,
            let data = data {
                //handle no error scenario
                do {
                    let decodedData: [NewsData] = try JSONDecoder().decode([NewsData].self, from: data)
                    completionBlock(decodedData, nil)
                }
                    catch {
                        let error = NSError(domain: "Failed to decode", code: 234)
                        completionBlock(nil, error)
                    }
                
            } else {
                // handle error scenario
                print("error: \(error.debugDescription)")
                completionBlock(nil, error)
            }
        }
        
        session.resume()
    }
    
    //Nested objects json response
    static func fetchTopHeadLines(countryString: String = "in",
                                  completion: @escaping ((_ topHeadLines: TopHeadLines?, _ error: Error?) -> Void))
    {
        let urlString = "https://newsapi.org/v2/top-headlines"
        var url = URL(string: urlString)
        url?.append(queryItems: [URLQueryItem(name: "apiKey",
                                              value: "4334c2ab1c8c4a22b57b5004ffd04362"),
                                 URLQueryItem(name: "country",
                                              value: "in")])
        guard let url = url else { return }
        let urlSession = URLSession.shared.dataTask(with: url) {(data, urlResponse, error) in
            
            if error == nil,
            let data = data {
                do {
                    let decodedData: TopHeadLines = try JSONDecoder().decode(TopHeadLines.self, from: data)
                    decodedData.printTopHeadLinesAsObject()
                    completion(decodedData, nil)
                }
                catch {
                    let error = NSError(domain: "Failed to decode", code: 234)
                    completion(nil, error)
                }
            }
        }
        
        urlSession.resume()
    }
}
