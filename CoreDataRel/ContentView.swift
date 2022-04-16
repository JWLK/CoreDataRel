//
//  ContentView.swift
//  CoreDataRel
//
//  Created by JWLK on 2021/06/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)])
    var User: FetchedResults<UserEntity>
    
    @State var textInputData: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                TextField("", text: $textInputData)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground).cornerRadius(10))
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                Button(action: {
                    addItem()
                }){
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundColor(.white)
                        .background(Color.black.cornerRadius(10))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                }
                List {
                    ForEach(User) { users in
                        Text(users.name ?? "아이템 없음")
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Core Data")
            .navigationBarItems(
                leading: EditButton()
            )
            
        }
    }
    
    private func addItem() {
        withAnimation {
        //newItem 이라는 빈항목을 생성
            let newUser = UserEntity(context: viewContext)
            //현재 날짜인 timestamp 수행
            newUser.name = textInputData
            textInputData = ""
            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let UserEntity = User[index]
            viewContext.delete(UserEntity)
            saveItems()
        }
    }
    
    private func saveItems() {
        //context를 호출하는 do state. save를 호출하고 오류가 발생하면 error 호출
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
