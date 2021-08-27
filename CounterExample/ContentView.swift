//
//  ContentView.swift
//  CounterExample
//
//  Created by Ralf Ebert on 27.08.21.
//

import SwiftUI

class CounterModel: ObservableObject {

    @Published var value = 0

    func increment() {
        self.value += 1
    }

}

struct ContentView: View {
    @StateObject var counterModel = CounterModel()

    var body: some View {
        VStack {
            Text("Counter value: \(self.counterModel.value)")
                .padding()

            Button("Increment") {
                self.counterModel.increment()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
