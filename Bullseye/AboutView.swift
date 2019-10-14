//
//  AboutView.swift
//  Bullseye
//
//  Created by André Brandão  on 14/10/2019.
//  Copyright © 2019 andrebp. All rights reserved.
//

import SwiftUI

struct AboutView: View {

    let beige = Color(red : 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct headingStyle : ViewModifier {
        func body(content : Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold",size: 30))
                .foregroundColor(Color.black)
                .padding(.bottom,20)
                .padding(.top,20)
        }
    }
    
    struct textStyle : ViewModifier {
        func body(content : Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold",size: 16))
                .foregroundColor(Color.black)
                .padding(.bottom,20)
                .padding(.leading,60)
                .padding(.trailing,60)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Bullsey 🎯").modifier(headingStyle())
                Text("This is Bullseye, the game where you can win points by dragging a slider.").modifier(textStyle())
                Text("Enjoy!").modifier(textStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(beige)
        } .background(Image("Background"))
    }
}
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
