//
//  ContentView.swift
//  Bullseye
//
//  Created by André Brandão  on 11/10/2019.
//  Copyright © 2019 andrebp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible : Bool = false
    @State var sliderValue: Double = 50.0
    
    
    var body: some View {
        VStack {
            Spacer()
//            Target Row
            HStack {
                Text("Put the bullseye as close as you can to:")
//                var numberToGuess : Int = random()
                Text("100")
            }
            Spacer()
//            Slider Row
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
//            Button Row
            Button(action: {
                self.alertIsVisible = true;
                print("button pressed")
            }) {
                Text("Knock Knock")
            }.alert(isPresented: $alertIsVisible) { () ->
                Alert in return
                Alert(title: Text("Value:"),
                      message: Text("The slider's value is \(Int(self.sliderValue.rounded()))."),
                      dismissButton: .default(Text("Ok!")))
            }
            Spacer()
//           Score Row
            HStack{
                
                Button(action: {
                    
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("0")
                Spacer()
                Text("Round:")
                Text("0")
                Spacer()
             
                Button(action : {
                    
                }) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
