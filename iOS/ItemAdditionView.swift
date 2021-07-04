//
//  ItemAdditionView.swift
//  ToDo (iOS)
//
//  Created by 王瑞果 on 2021/7/4.
//

import SwiftUI

struct ItemAdditionView: View {
    @EnvironmentObject var persistenceController: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var title: String = ""
    @State var note: String = ""
    @State var dueDate = Date()
    @State var isCollected: Bool = false
    @State var isCompleted: Bool = false
    
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
                
                Section(header: Text("操作")) {
                    Button(action: {
                        let isOk = persistenceController.createItem(title: self.title, dueDate: self.dueDate, note: self.note, isCollected: self.isCollected)
                        if isOk {
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
}

struct ItemAdditionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemAdditionView()
    }
}
