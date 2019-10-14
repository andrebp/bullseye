//
//  ContentView.swift
//  Bullseye
//
//  Created by André Brandão  on 11/10/2019.
//  Copyright © 2019 andrebp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var currentScore = 0
    @State var round = 1
    let midnightBlue = Color(red : 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold",size: 18))
        }
    }
    
    struct ValueStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    func pointsForCurrentRound() -> Int {
        let difference = differenceTargetSliderValues(target : self.target, slider : sliderValueRounded())
        
        var awardedPoints = 100 - difference
        
        if difference == 0 {
            awardedPoints += 100
        } else if difference == 1 {
            awardedPoints += 50
        }
        
        return awardedPoints
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func differenceTargetSliderValues(target : Int, slider : Int) -> Int {
        let res = target - slider
        return abs(res)
    }
    
    func alertText() -> String {
        let diff = differenceTargetSliderValues(target: self.target, slider: sliderValueRounded())
        
        switch diff {
        case 0:
            return "Perfect!"
        
        case 1 ... 5 :
            return "Almost!"
        
        case 6 ... 10:
            return "Not Bad!"
            
        default:
            return "Not even close..."
        }
    }
    
    func resetGame() {
        self.round = 1
        self.currentScore = 0
        self.target = Int.random(in: 1...100)
    }
    
    var body: some View {
        VStack {
            Spacer()
//            Target Row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
//            Slider Row
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
//            Button Row
            Button(action: {
                print("button pressed")
                self.alertIsVisible = true;
            }) {
                Text("Hit Me!").modifier(ButtonLargeTextStyle())
            }.alert(isPresented: $alertIsVisible) { () ->
                Alert in return
                Alert(title: Text(alertText()),
                      message: Text("The slider's value is \(sliderValueRounded()).\n" + "You scored \(self.pointsForCurrentRound()) points this round."),
                      dismissButton: .default(Text("Ok!")) {
                        self.currentScore += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button")).modifier(Shadow()).accentColor(Color.yellow)
            Spacer()
//           Score Row
            HStack{
                
                Button(action: {
                    self.resetGame()
                }) {
                    HStack{
                        Image("StartOverIcon").accentColor(midnightBlue)
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow()).accentColor(Color.yellow)
                
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(self.currentScore)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(self.round)").modifier(ValueStyle())
                Spacer()
             
                NavigationLink(destination : AboutView())  {
                    HStack{
                        Image("InfoIcon").accentColor(midnightBlue)
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow()).accentColor(Color.yellow)
            }.padding(.bottom, 20)
            
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("Bullsey")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
