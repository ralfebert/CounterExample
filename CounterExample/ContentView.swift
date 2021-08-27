//
//  ContentView.swift
//  CounterExample
//
//  Created by Ralf Ebert on 27.08.21.
//

import SwiftUI

class CounterModel: ObservableObject {

    var value = 0

    func increment() {
        DispatchQueue.concurrentPerform(iterations: 10000) { idx in
            self.value += 1
            // Only send the change notification every 100 iterations makes data races much more likely
            if (idx + 1) % 100 == 0 {
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
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
