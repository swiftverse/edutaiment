//
//  ContentView.swift
//  edutainment
//
//  Created by Amit Shrivastava on 21/11/21.
//

import SwiftUI

struct Edutainment: View {
    
    init() {
         // UIScrollView.appearance().backgroundColor = UIColor.cyan
        UIScrollView.appearance().backgroundColor = .clear
    }
    
    let gradient = LinearGradient(colors: [Color.orange,Color.green],
                                  startPoint: .top, endPoint: .bottom)
    @State private var tableSelect = 2
    @State private var questionAsked = 0
    private var questionsArray = [2, 5, 10]
    
    
    var body: some View {
        
        
        
        
        
        
        NavigationView {
            
            VStack {
                
                
                
                ZStack {
                    gradient
                        .opacity(0.25)
                        .ignoresSafeArea(.all)
                    
                    
                    Form {
                        
                        Section("Select the table") {
                            Stepper("\(tableSelect)", value: $tableSelect, in: 2...10, step: 1) {
                                print("\($0)")
                            }
                        }
                        Section("How many questions for this table ?"){
                            Picker("How many Questions", selection: $questionAsked) {
                                ForEach(questionsArray, id: \.self) {
                                    num in
                                    Text("\(num)")
                                    
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        Section {
                            NavigationLink(destination: Question(tableSelect: $tableSelect  , questionAsked: $questionAsked)) {
                                Text("Start")
                            }
                        }
                        
                        
                    }
                }
                
                
                
            }
            
            
            // .background(.orange)
            
            .navigationTitle("Edutainment")
            
            
        }
   }
}

struct Edutainment_Previews: PreviewProvider {
    static var previews: some View {
        Edutainment()
    }
}
