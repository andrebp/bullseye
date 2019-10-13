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
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
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
                print("button pressed")
                self.alertIsVisible = true;
            }) {
                Text("Hit Me!")
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
            Spacer()
//           Score Row
            HStack{
                
                Button(action: {
                    self.resetGame()
                }) {
                    Text("Start Over")
                }
                
                Spacer()
                Text("Score:")
                Text("\(self.currentScore)")
                Spacer()
                Text("Round:")
                Text("\(self.round)")
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
