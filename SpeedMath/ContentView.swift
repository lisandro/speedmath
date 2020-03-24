//
//  ContentView.swift
//  SpeedMath
//
//  Created by Lisandro Falconi on 21/03/2020.
//  Copyright © 2020 Lisandro Falconi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var questions = [Question]()
    @State private var  currentQuestion = 0

    var score: Int {
        var total = 0
        for i in 0..<currentQuestion {
            if questions[i].userAnswer == questions[i].actualAnswer {
                total += 1
            }
        }
        return total
    }

    var body: some View {
        ZStack {
            ForEach(0..<questions.count, id: \.self) { index in
                QuestionRow(question: self.questions[index], position: self.position(for: index))
                    .offset(x: 0, y: self.questionOffset(for: index))
            }

            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                    .padding()
                    .background(Capsule().fill(Color.white.opacity(0.8)))
                    .animation(nil)
                }
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()

                Spacer()

            }
            .padding()
        }
        .frame(width: 1000, height: 600)
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear(perform: createQuestion)
        .onReceive(NotificationCenter.default.publisher(for: .enterNumber )) { note in
            guard let number = note.object as? Int, let _ = self.questions[safe: self.currentQuestion]  else { return }

            if self.questions[self.currentQuestion].userAnswer.count < 3 {
                self.questions[self.currentQuestion].userAnswer += String(number)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .removeNumber )) { _ in
            guard let _ = self.questions[safe: self.currentQuestion] else { return }
            _ = self.questions[self.currentQuestion].userAnswer.popLast()
        }
        .onReceive(NotificationCenter.default.publisher(for: .submitAnswer )) { _ in
            if self.questions[safe: self.currentQuestion]?.userAnswer.isEmpty == false {
                withAnimation {
                    self.currentQuestion += 1
                }
            }
        }
    }

    func createQuestion() {
        for _ in 1...50 {
            questions.append(Question())
        }
    }

    func position(for index: Int) -> Position {
        if index < currentQuestion {
            return .answered
        } else if index == currentQuestion {
            return .current
        } else {
            return .upcoming
        }
    }

    func questionOffset(for index: Int) -> CGFloat {
        return CGFloat(index) * 100 - CGFloat(self.currentQuestion) * 100
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
