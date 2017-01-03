//
//  ViewController.swift
//  Web Service Example
//
//  Created by Daniel Springer on 02/01/2017.
//  Copyright © 2017 Daniel Springer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forecastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPSessionManager()
        
        manager.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=450cd998ac2e3419b024a8237eea8b54",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject:Any?) in
                        if let responseObject = responseObject {
                            print("Response: " + (responseObject as AnyObject).description)
                            if let listOfDays = (responseObject as AnyObject)["list"] as? [AnyObject] {
                                if let tomorrow = listOfDays[0] as? [String:AnyObject] {
                                    if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
                                        if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
                                            if let forecast = firstWeatherOfDay["description"] as? String {
                                                self.forecastLabel.text = forecast
                                            }
                                        }
                                    }
                                }
                            }
                        }
        }) { (operation:URLSessionDataTask?, error:Error) in
            print("Error: " + error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

