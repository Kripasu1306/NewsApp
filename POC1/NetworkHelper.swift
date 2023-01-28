//
//  NetworkHelper.swift
//  POC1
//
//  Created by Satvik Subramanian on 17/01/23.
//

import UIKit

class NetworkHelper: NSObject {
    //Get one array.
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
}
