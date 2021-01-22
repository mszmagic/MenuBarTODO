//
//  ContentView.swift
//  MenuBarTODO
//
//  Created by Shunzhe Ma on R 3/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TODOItem.addedDate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<TODOItem>
    
    @State private var newItemContent: String = ""
    
    @State private var showTodoItems: Bool = true
    @State private var showCompletedTodoItems: Bool = true
    
    var body: some View {
        VStack {
            /* 新しいToDoアイテムを追加するためのセレクション */
            HStack {
                TextField("", text: $newItemContent)
                Button(action: {
                    guard !newItemContent.isEmpty else { return }
                    let newItem = TODOItem(context: StorageHelper.shared.storageContext)
                    newItem.itemID = UUID().uuidString
                    newItem.addedDate = Date()
                    newItem.itemIsCompleted = false
                    newItem.itemContent = newItemContent
                    try? StorageHelper.shared.storageContext.save()
                    self.newItemContent = ""
                }, label: {
                    Image(systemName: "plus")
                })
            }
            /* ToDoアイテムのリスト */
            DisclosureGroup("TODO", isExpanded: $showTodoItems) {
                ScrollView {
                    ForEach(self.items.filter({ item in
                        return !item.itemIsCompleted
                    })) { item in
                        HStack {
                            Button(action: {
                                item.itemIsCompleted = true
                                try? StorageHelper.shared.storageContext.save()
                            }, label: {
                                HStack {
                                    Image(systemName: "circle")
                                    Text(item.itemContent ?? "")
                                        .frame(width: 300)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                }
                            })
                            Button(action: {
                                StorageHelper.shared.storageContext.delete(item)
                                try? StorageHelper.shared.storageContext.save()
                            }, label: {
                                Image(systemName: "trash")
                            })
                        }
                    }
                }
            }
            /* 完了済みのToDoアイテムのリスト */
            DisclosureGroup(isExpanded: $showCompletedTodoItems) {
                ScrollView {
                    ForEach(self.items.filter({ item in
                        return item.itemIsCompleted
                    })) { item in
                        HStack {
                            Button(action: {
                                item.itemIsCompleted = false
                                try? StorageHelper.shared.storageContext.save()
                            }, label: {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(item.itemContent ?? "")
                                        .foregroundColor(.secondary)
                                        .frame(width: 300)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                }
                            })
                            Button(action: {
                                StorageHelper.shared.storageContext.delete(item)
                                try? StorageHelper.shared.storageContext.save()
                            }, label: {
                                Image(systemName: "trash")
                            })
                        }
                    }
                }
            } label: {
                Image(systemName: "checkmark.circle")
            }
        }
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
