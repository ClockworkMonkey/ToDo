//
//  ItemView.swift
//  ToDo
//
//  Created by 王瑞果 on 2021/6/30.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var item: Item
    @State private var isShowItemEditingView: Bool = false

    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 10.0)
                .foregroundColor(.blue)

            Button(action: {
                self.isShowItemEditingView.toggle()
            }) {
                Group {
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text(self.item.unwrappedTitle)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Text(self.item.unwrappedDueDate.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                }
            }
            .sheet(isPresented: self.$isShowItemEditingView, content: {
                ItemEditingView(item: self.item)
            })
            
            Spacer()
            
            Image(systemName: self.item.isCollected ? "star.fill" : "star")
                .imageScale(.large)
                .padding(.trailing)
                .foregroundColor(self.item.isCollected ? .yellow : .black )

            Image(systemName: self.item.isCompleted ? "checkmark.square" : "square")
                .imageScale(.large)
                .padding(.trailing)
                .foregroundColor(.black)
        }
        .frame(height: 80.0)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(radius: 10.0, x: 0.0, y: 10.0)
    }
}

 struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item.example)
    }
 }
