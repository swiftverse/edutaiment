//
//  Question.swift
//  edutainment
//
//  Created by Amit Shrivastava on 21/11/21.
//

import SwiftUI

struct Question: View {
    @Binding var tableSelect: Int
    @Binding var questionAsked: Int
    @State var animationAmount = 0.0
    @State var correctAnswers = 0
    @State var showingScore = false
    @State var scoreTitle = ""
    @State var randomQuestion: Int
    @State var ask = false
    @State var questionCompleted = 0
    @State var showEdutainment = false
    var quizButtons = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].shuffled()
    
    
    var emoji: [String] {
        ["bear", "buffalo", "cow", "chick", "chicken", "cow", "crocodile", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit"].shuffled()
    }
    
    
    private var answers: [Int] {
        [0 * tableSelect, 1 * tableSelect, 2 * tableSelect, 3 * tableSelect, 4 * tableSelect, 5 * tableSelect, 6 * tableSelect, 7 * tableSelect, 8 * tableSelect, 9 * tableSelect, 10 * tableSelect,11 * tableSelect, 12 * tableSelect, 13 * tableSelect, 14 * tableSelect, 15 * tableSelect, 16 * tableSelect, 17 * tableSelect, 18 * tableSelect, 19 * tableSelect, 20 * tableSelect]
    }
    
    
    init(tableSelect: Binding<Int>, questionAsked: Binding<Int>){
        self._tableSelect = tableSelect
        self._questionAsked = questionAsked
        randomQuestion = quizButtons.prefix(4).randomElement()!
    }
    
    var body: some View {
        
        NavigationLink(destination: Edutainment(), isActive: self.$showEdutainment) { EmptyView() }

        ZStack(alignment: .top) {
            LinearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom)
                .opacity(0.25)
                .ignoresSafeArea(.all)
            VStack {
                Label {
                    Text("what is \(tableSelect) * \(randomQuestion) ")
                        .font(.title)
                } icon: {
                    Image(emoji[0])
                        .resizable()
                        .frame(width: 50, height: 50)
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2)) {
                                animationAmount += 360
                            }
                        }
                }
                
                
                VStack {
                    
                    VStack(spacing: 20) {
                        
                        ForEach(quizButtons.prefix(4), id:\.self) {
                            number in
                            Button {
                                questionCompleted += 1
                                buttonTapped(number)
                            } label: {
                                HStack {
                                    Image(emoji[number])
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .rotation3DEffect(.degrees(animationAmount), axis: (0, 1, 0))
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 2)) {
                                                
                                                animationAmount += 360
                                               
                                            }
                                        }
                                    
                                    Text("\(self.answers[number])")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .frame(width: 200, height: 100)
                                        .cornerRadius(20)
                                }
                            }
                            .frame(width: 300, height: 100)
                            .background(.cyan)
                            .cornerRadius(20)
                        }
                    }
                    if(questionAsked != 0){
                        Text("Total score \(correctAnswers) of \(questionAsked)")
                            .font(.title)
                    }
                    
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    
                    if(questionCompleted <= questionAsked){
                        Button("Continue") {
                            askQuestion()
                        }
                    }
                    else {
                    }
                }
            }
        }
    }
    
    
    func buttonTapped(_ correctVal: Int) {
        if(questionCompleted <= questionAsked) {
            if (randomQuestion * tableSelect) == (correctVal * tableSelect) {
                //  askQuestion()
                ask = true
                scoreTitle = "Correct Answer"
                correctAnswers += 1
               
            } else {
                ask = true
                scoreTitle = "Wrong Answer"
               
            }
            showingScore = true
        }
        else {
        }
    }

    func askQuestion() {
        randomQuestion = quizButtons.prefix(4).randomElement()!
        ask = true
        if(questionAsked == questionCompleted) {
            self.showEdutainment = true
        }
    }
}


struct Question_Previews: PreviewProvider {
    @State static var tableSelect = 0
    @State static var questionAsked = 0
    static var previews: some View {
        Question(tableSelect: $tableSelect, questionAsked: $questionAsked)
    }
}
