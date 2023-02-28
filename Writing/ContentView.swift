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
    @State private var showTopics = false
    @FocusState private var noteFocused: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text("New write")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    ScrollView {
                        TextEditor(text: $note)
                            .focused($noteFocused)
                            .foregroundColor(.gray)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            .onAppear {
                                noteFocused = true
                            }
                    }
                    Spacer()
                    Spacer()
                    
                    Button {
                        Task {
                            do {
                                let completion = try await Service.makeCompletion(with: note)
                                let newNote = (completion.choices.first?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).filter{!$0.isEmpty}.joined(separator: "\n")
                                finalNote = newNote
                                showTopics.toggle()
                            } catch let error {
                                print("something went wrong: ", error)
                            }
                        }
                    } label: {
                        Text("Get themes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 48/255, green: 116/255, blue: 118/255))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            if showTopics {
                Topics(topics: finalNote) {
                    showTopics.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
