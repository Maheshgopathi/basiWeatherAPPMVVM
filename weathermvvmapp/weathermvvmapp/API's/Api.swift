//
//  Api.swift
//  weathermvvmapp
//
//  Created by Gopathi Mahesh on 13/10/22.
//


import Foundation
import Alamofire
import UIKit
import SwiftyJSON

struct iden: Identifiable {
    var id = UUID()
    var name: String
    var clouds: Int
    var humidity: Int
    var speed: Double
    var pressure: Int
    var temp: Double
    var image: String
}

extension ContentView {
    @MainActor class viewModel: ObservableObject {
        @Published var cityName: String
        @Published var storeInArray = [iden]()
        
        let HomePage = ContentView()
        
        init() {
            self.cityName = HomePage.cityName
            if self.cityName.isEmpty {
                self.cityName = "Delhi"
                
            }
        }
        func value() {
          
            let urlLogin = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=116218f52894f2c3fb139486930b32fb"
            Alamofire.request(urlLogin, method: .get).responseJSON{
                [self]
                response in
                
                print(response)
                
                let json = try! JSON(data: response.data!)
                print(json)
                
                guard json["cod"] != "404" else{
                    return
                }
                
                let name = json["name"].string!
                let clouds = json["clouds"]["all"].int!
                let humidity = json["main"]["humidity"].int!
                let speed = json["wind"]["speed"].doubleValue
                let pressure = json["main"]["pressure"].int!
                let temp = json["main"]["temp"].double!
                let image = json["weather"][0]["icon"].string!
                storeInArray.append(iden(name: name, clouds: clouds, humidity: humidity, speed: speed, pressure: pressure, temp: temp, image: image))
            }
        
        }
        
        
        
    }
}

