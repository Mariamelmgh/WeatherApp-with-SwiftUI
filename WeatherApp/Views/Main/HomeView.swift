//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mariam El Mgharaz on 26/4/2023.
//

import SwiftUI
import BottomSheet

enum BottmSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}


struct HomeView: View {
    
    @State var bottomSheetPosition : BottmSheetPosition = .middle
    @State var bottomSheetTranslation : CGFloat = BottmSheetPosition.middle.rawValue
    @State var hasDragged : Bool = false
    var bottomSheetTranslationPrerated: CGFloat{
        (bottomSheetTranslation - BottmSheetPosition.middle.rawValue) / (BottmSheetPosition.top.rawValue - BottmSheetPosition.middle.rawValue)

    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHieght = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOfSet  = screenHieght +  36
                ZStack{
                    
                    //MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    
                    //MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationPrerated * imageOfSet)
                    
                    
                    //MARK: Add House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationPrerated * imageOfSet)
                    
                    //MARK: Current Weather
                    VStack(spacing:  -10 * (1 - bottomSheetTranslationPrerated)){
                    
                        Text("Montreal").font(.largeTitle)
                    
                        VStack {
                            Text(attributedString)
                            
                            Text("H:24°     L:18°")
                            .font(.title3.weight(.semibold))
                            .opacity(1 - bottomSheetTranslationPrerated)
                        }
                        
                            
                        
                        
                        Spacer()
                        
                    }.padding(.top,51)
                        .offset(y: -bottomSheetTranslationPrerated * 46)
                    //MARK: add Bottom Sheet
                    BottomSheetView(position: $bottomSheetPosition) {
                        
                      
                    } content: {
                        
                        ForecastView(bottomSheetTranslationParated: bottomSheetTranslationPrerated)
                    }.onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHieght
                        withAnimation(.easeInOut) {
                            hasDragged = bottomSheetPosition == BottmSheetPosition.top ?  true: false
                        }
                       
                    }

                    //MARK: add Tab Bar
                    TabBar {
                        bottomSheetPosition = .top
                    }.offset(y:bottomSheetTranslationPrerated * 115)
                   
                }
            }.navigationBarHidden(true)
        }
    }
    
    
    private var attributedString : AttributedString{
        var string = AttributedString("19°" + (hasDragged ? " | " :"\n " ) + "Mostly Clear")
        
        if let temp = string.range(of: "19°"){
            
            string[temp].font = .system(
                size: (96 - (bottomSheetTranslationPrerated * (96 - 20)))
                , weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ?  .secondary :  .primary
            
        }
        
        if let pipe = string.range(of: " | "){
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationPrerated)
        }
        
        if let weather = string.range(of: "Mostly Clear"){
            
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        
        
        return string
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView().preferredColorScheme(.dark)
    }
}
