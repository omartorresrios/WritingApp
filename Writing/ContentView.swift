//
//  ContentView.swift
//  Writing
//
//  Created by Omar Torres on 23/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var note = ""
    @State private var finalNote = ""
    @FocusState private var noteFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text("New write")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    TextEditor(text: $note)
                        .focused($noteFocused)
                        .frame(height: 300)
                        .foregroundColor(.gray)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .onAppear {
                            noteFocused = true
                        }
                    
                    Divider()
                    
                    Button {
                        Task {
                            do {
                                let completion = try await Service.makeCompletion(with: note)
                                finalNote = completion.choices.first?.text ?? ""
                                note = ""
                            } catch let error {
                                print("something went wrong: ", error)
                            }
                        }
                    } label: {
                        Text("Generate text")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading) {
                        Text("First paragraph")
                            .background(.gray)
                            .foregroundColor(.white)
                        Text(finalNote)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
