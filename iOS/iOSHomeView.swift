//
//  iOSHomeView.swift
//  ToDo (iOS)
//
//  Created by 王瑞果 on 2021/6/30.
//

import SwiftUI

struct iOSHomeView: View {
    @EnvironmentObject var persistenceController: PersistenceController
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.dueDate, ascending: true)],
        animation: .default
    ) private var items: FetchedResults<Item>
    @State private var isShowItemAdditionView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(items, id: \.id) { item in
                        ItemView(item: item)
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let item = items[index]
                            persistenceController.container.viewContext.delete(item)
                        }
                    })
                }
                .listStyle(SidebarListStyle())
                .navigationBarTitle(Text("待办事项"))
            }
                
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        
                    Button(action: {
                         self.isShowItemAdditionView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                    .sheet(isPresented: self.$isShowItemAdditionView, content: {
                        ItemAdditionView()
                    })
                }
            }
        }
    }
}

struct iOSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        iOSHomeView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(PersistenceController.shared)
    }
}
