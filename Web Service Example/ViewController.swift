//
//  ViewController.swift
//  Web Service Example
//
//  Created by Daniel Springer on 02/01/2017.
//  Copyright © 2017 Daniel Springer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundColor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let manager = AFHTTPSessionManager()
        
        manager.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=Nice&mode=json&units=metric&cnt=1&appid=450cd998ac2e3419b024a8237eea8b54",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject:Any?) in
                        
                        // Using SwiftyJSON
                        let json = JSON(responseObject!)
                        
                        if let location = json["city"]["name"].string {
                            self.locationLabel.text = location
                        }
                        
                        if let forecast = json["list"][0]["weather"][0]["description"].string {
                            self.forecastLabel.text = forecast.uppercased()
                        }
                        
                        if let temp = json["list"][0]["temp"]["day"].double {
                            self.tempLabel.text = String(temp)+"\u{00b0}"
                        }
                        if let temperature = json["list"][0]["temp"]["day"].double {
                            
                            switch temperature {
                            case -20.0...0.0:
                                self.backgroundColor.backgroundColor = UIColor.blue
                            case 0.0...12.0:
                                self.backgroundColor.backgroundColor = UIColor.cyan
                            case 12.0...16.0:
                                self.backgroundColor.backgroundColor = UIColor.yellow
                            case 17.0...19.0:
                                self.backgroundColor.backgroundColor = UIColor.orange
                            case 20.0..<24.0:
                                self.backgroundColor.backgroundColor = UIColor.red
                            default:
                                self.backgroundColor.backgroundColor = UIColor.clear
                            }
                print(json)
                        }
//                        if let responseObject = responseObject {
//                            print("Response: " + (responseObject as AnyObject).description)
//                            if let listOfDays = (responseObject as AnyObject)["list"] as? [AnyObject] {
//                                if let tomorrow = listOfDays[0] as? [String:AnyObject] {
//                                    if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
//                                        if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
//                                            if let forecast = firstWeatherOfDay["description"] as? String {
//                                                self.forecastLabel.text = forecast
//                                                
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
        }) { (operation:URLSessionDataTask?, error:Error) in
            print("Error: " + error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

