//
//  ItemEditingView.swift
//  ToDo (iOS)
//
//  Created by 王瑞果 on 2021/7/4.
//

import SwiftUI

struct ItemEditingView: View {
    @EnvironmentObject var persistenceController: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let item: Item
    @State var title: String = ""
    @State var note: String = ""
    @State var dueDate = Date()
    @State var isCollected: Bool = false
    @State var isCompleted: Bool = false
    
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.unwrappedTitle)
        _dueDate = State(wrappedValue: item.unwrappedDueDate)
        _note = State(wrappedValue: item.unwrappedNote)
        _isCollected = State(wrappedValue: item.isCollected)
        _isCompleted = State(wrappedValue: item.isCompleted)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("事项")) {
                    TextField("事项内容", text: self.$title)
                    DatePicker(selection: self.$dueDate, label: { Text("截止日期") })
                    Toggle("是否收藏", isOn: self.$isCollected)
                    ZStack(alignment: .leading) {
                        if self.note.isEmpty {
                            Text("备注")
                                .foregroundColor(.gray)
                        }
                            
                        TextEditor(text: self.$note)
                    }
                }
                
                Section(header: Text("状态")) {
                    Toggle("是否完成", isOn: self.$isCompleted)
                }
                
                Section(header: Text("操作")) {
                    Button(action: {
                        let isUpdated = updateItem()
                        if isUpdated {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("确定")
                    }
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("取消")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle(Text("待办事项"))
        }
    }
    
    @discardableResult
    func updateItem() -> Bool {
        item.title = title
        item.dueDate = dueDate
        item.note = note
        item.isCollected = isCollected
        item.isCompleted = isCompleted
        return persistenceController.updateItem(item)
    }
}

struct ItemEditingView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditingView(item: Item.example)
    }
}
