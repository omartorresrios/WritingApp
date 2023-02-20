//
//  TopicsView.swift
//  Writing
//
//  Created by Omar Torres on 13/02/23.
//

import SwiftUI

struct TopicsView: View {
    var topics: String
    let completion: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Topics on this text")
                .font(.title3)
                .fontWeight(.bold)
            Text(topics)
                .font(.headline)
            Button {
                completion()
            } label: {
                Text("Ok")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 48/255, green: 116/255, blue: 118/255))
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(red: 48/255, green: 116/255, blue: 118/255))
        .cornerRadius(10)
    }
}

struct TopicsView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView(topics: "Some topic\nAnother topic\nAnother topic\nAnother topic\nAnother topic\nAnother topic",
        completion: {})
    }
}
