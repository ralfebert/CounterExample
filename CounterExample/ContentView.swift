//
//  ContentView.swift
//  CounterExample
//
//  Created by Ralf Ebert on 27.08.21.
//

import SwiftUI

class Person {

    let name: String

    init(name: String) {
        self.name = name
    }

}

class RandomPersonModel: ObservableObject {

    var person: Person?

    let values = [Person(name: "Alice"), Person(name: "Bob")]

    func pickRandomPerson() {
        DispatchQueue.concurrentPerform(iterations: 10000) { idx in
            self.person = values.randomElement()!
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
    @StateObject var model = RandomPersonModel()

    var body: some View {
        VStack {
            Text("Person: \(self.model.person.map(\.name) ?? "-")")
                .padding()

            Button("Increment") {
                self.model.pickRandomPerson()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
