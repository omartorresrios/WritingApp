//
//  Note.swift
//  Writing
//
//  Created by Omar Torres on 20/02/23.
//

import SwiftUI

struct Note: View {
    @Binding var note: Note
    
    var body: some View {
        VStack(spacing: 2.0) {
            TextField("Note title", text: $note.title, axis: .vertical)
                .padding([.leading, .trailing], 4)
            
            TextEditor(text: $note.body)
                .foregroundColor(.gray)
                .font(.body)
        }
        .padding()
    }
}

struct Note_Previews: PreviewProvider {
    static var previews: some View {
        Note(note: .constant(Note(id: 1,
                                      title: "Some title",
                                      body: "Some body")))
    }
}
