//
//  ContentView.swift
//  weathermvvmapp
//
//  Created by Gopathi Mahesh on 13/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName = ""
    
    @StateObject var viewMode = viewModel()
    
    let colorTitle = RadialGradient(gradient: Gradient(colors: [.white, .secondary]), center: .center, startRadius: 430, endRadius: 30)
    let color1 = LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("Enter City Name Weather")
                    TextField("Enter a City", text: $cityName)
                        .multilineTextAlignment(.center)
                    
                    Button("Search"){
                        
                       viewMode.cityName = cityName
                        viewMode.value()
                            
                    }.font(.system(size: 20, weight: .semibold))
                    List($viewMode.storeInArray){$data in
                        Text("\(data.name)").fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .listRowBackground(colorTitle)
                            .frame(width: .infinity,  alignment: .center)
                        HStack{
                            VStack{
                                Image("\(data.image)")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)
                            }
                            VStack{
                                Text("Temp: \(data.temp, specifier: "%.2f") °C").fontWeight(.bold)
                                Text("Clouds: \(data.clouds)%").fontWeight(.bold)
                                Text("Humidity: \(data.humidity)%").fontWeight(.bold)
                                Text("Speed: \(data.speed, specifier: "%.2f")m/s").fontWeight(.bold)
                                Text("Pressure: \(data.pressure)hpa").fontWeight(.bold)
                                
                            }
                        }.listRowBackground(color1)
                        
                    }
                      
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
