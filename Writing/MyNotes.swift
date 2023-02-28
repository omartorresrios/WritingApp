//
//  MyNotesView.swift
//  Writing
//
//  Created by Omar Torres on 20/02/23.
//

import SwiftUI

struct Note: Identifiable {
    let id: Int
    var title: String
    var body: String
}

struct MyNotes: View {
    
    @State private var notes: [Note] =
        [Note(id: 1, title: "Some title", body: "A fake body"),
         Note(id: 2, title: "Another title", body: "A fake body A fake body A fake body A fake body A fake body A fake body A fake body A fake body A fake body A fake body")]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach($notes) { $note in
                        NavigationLink {
                            Note(note: $note)
                        } label: {
                            Text(note.title)
                        }
                    }
                }
                .navigationTitle("My notes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct MyNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MyNotes()
    }
}
