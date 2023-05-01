//
//  TabBar.swift
//  WeatherApp
//
//  Created by Mariam El Mgharaz on 26/4/2023.
//

import SwiftUI

struct TabBar: View {
    //Properties
    var action: () -> Void
    
    
    
    var body: some View {
        
        ZStack{
            //MARK: Add Arc shapes
            Arc()
                .fill(Color.tabBarBackground)
                .background(Color.tabBarBackground)
                .frame(height: 88)
                .overlay{
                    Arc()
                        .stroke(Color.tabBarBorder,lineWidth: 0.5)
                }
                
            HStack{
                
                
                  
                //MARK: Add Button
                Button{
                    action()
                    
                }label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                //MARK: Navigaation Button
                NavigationLink(destination:WeatherView()) {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
            }
        }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }.frame( maxHeight: .infinity , alignment: .bottom).ignoresSafeArea()
        
      
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(action: {
            
        })
            .preferredColorScheme(.dark)
    }
    
}
