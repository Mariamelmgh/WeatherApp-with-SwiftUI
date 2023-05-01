//
//  Blur.swift
//  WeatherApp
//
//  Created by Mariam El Mgharaz on 27/4/2023.
//

import SwiftUI

class UIBackdropView: UIView{
    override class var layerClass: AnyClass{
        NSClassFromString("CABackdropLayer") ?? CALayer.self
    }
    
    
}

struct Backdrop: UIViewRepresentable{
    
    typealias UIViewType = UIBackdropView
    
    func makeUIView(context: Context) -> UIBackdropView {
        
        UIBackdropView()
    }
    
    func updateUIView(_ uiView: UIBackdropView, context: Context) {
        
    }
}

struct Blur: View {
    var radios: CGFloat = 3
    var opaque: Bool = false
    var body: some View {
        Backdrop().blur(radius: radios, opaque: opaque)
    }
}

struct Blur_Previews: PreviewProvider {
    static var previews: some View {
        Blur()
    }
}
