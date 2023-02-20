//
//  MyNotesView.swift
//  Writing
//
//  Created by Omar Torres on 20/02/23.
//

import SwiftUI

struct Note: Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct MyNotesView: View {
    
    var notes: [Note] {
        return [Note(id: 1, title: "Some title", body: "some_body"),
                Note(id: 2, title: "Another title", body: "another_body")]
    }
    
    var body: some View {
        VStack {
            Text("My notes")
            NavigationView {
                List {
                    ForEach(notes) { note in
                        NavigationLink {
                            
                        } label: {
                            Text(note.title)
                        }
                    }
                }
            }
        }
    }
}

struct MyNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MyNotesView()
    }
}
