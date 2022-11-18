//
//  ContentView.swift
//  Phone Dialer i
//
//  Created by Tyler Welch on 1/11/23.
//
import SwiftUI

@main
struct Toolbar16App: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

struct ContentView: View {
    @StateObject private var sceneState = SceneState()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationSplitView {
            NoteList()
        } detail: {
            ZStack {
                if let selection = sceneState.selectedNoteId {
                    NoteView(
                        text: $appState.notes[selection].text
                    )
                    .navigationTitle("Note \(appState.notes[selection].id + 1)")
                    .navigationBarTitleDisplayMode(.inline)
                } else {
                    Text("Nothing selected")
                }
            }
            .padding()
        }
        .environmentObject(sceneState)
    }
}

struct NoteList: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var sceneState: SceneState
    
    var body: some View {
        List(
            appState.notes,
            selection: $sceneState.selectedNoteId
        ) { note in
            NavigationLink(value: note.id) {
                Text("Note \(note.id + 1)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        let newNote = Note(text: "", id: appState.notes.count)
                        appState.notes.append(newNote)
                        sceneState.selectedNoteId = newNote.id
                    } label: {
                        Label("New Note", systemImage: "plus")
                            .labelStyle(.titleAndIcon)
                    }
                }
             }
        }
    }
}

struct NoteView: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .toolbar(id: "note") {
                ToolbarItem(id: "favorite", placement: .secondaryAction) {
                    FavoriteButton()
                }
                ToolbarItem(id: "tag", placement: .secondaryAction) {
                    TagButton()
                }
                ToolbarItem(id: "image", placement: .secondaryAction) {
                    ControlGroup {
                        AddPhotoButton()
                        AddDocumentScanButton()
                    }
                }
                ToolbarItem(id: "Find", placement: .secondaryAction,
                    showsByDefault: false
                ) {
                    FindButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    ShareButton()
                }
            }
            .toolbarRole(.editor)
    }
}

struct ShareButton: View {
    @EnvironmentObject var sceneState: SceneState
    @EnvironmentObject var appState: AppState

    var text: String {
        if let selection = sceneState.selectedNoteId {
            return appState.notes[selection].text
        }
        return ""
    }

    var body: some View {
        ShareLink("Share", item: text)
    }
}

struct FindButton: View {
    var body: some View {
        Button {
            // show find and replace UI
        } label: {
            Label("Find and replace", systemImage: "person.2.circle")
        }
    }
}

struct FavoriteButton: View {
    var body: some View {
        Button {
            // add selected note to favorites
        } label: {
            Label("Favorite", systemImage: "star")
        }
    }
}

struct TagButton: View {
    var body: some View {
        Button {
            // add a tag for selected note
        } label: {
            Label("Add Tag", systemImage: "number")
        }
    }
}

struct AddPhotoButton: View {
    var body: some View {
        Button {
            // present photos picker UI
        } label: {
            Label("Choose Photo", systemImage: "photo.on.rectangle")
        }
    }
}

struct AddDocumentScanButton: View {
    var body: some View {
        Button {
            // present document scanner UI
        } label: {
            Label("Scan Document", systemImage: "doc.viewfinder")
        }
    }
}

class SceneState: ObservableObject {
    @Published var selectedNoteId: Int?
}

class AppState: ObservableObject {
    @Published var notes: [Note] = []
}

struct Note: Identifiable {
    var text: String
    var id: Int
    var tags: [String] = []
}

import SwiftUI
import CoreData
//struct ContentView: View {
//    @StateObject private var sceneState = SceneState()
//    @EnvironmentObject var appState: AppState
//
//    var body: some View {
//        NavigationSplitView {
//            NoteList()
//        } detail: {
//            ZStack {
//                if let selection = sceneState.selectedNoteId {
//                    NoteView(
//                        text: $appState.notes[selection].text
//                    )
//                    .navigationTitle("Note \(appState.notes[selection].id + 1)")
//                    .navigationBarTitleDisplayMode(.inline)
//                } else {
//                    Text("Nothing selected")
//                }
//            }
//            .padding()
//        }
//        .environmentObject(sceneState)
//    }
//}
//
//struct Phone_dialer_i: View {
//    @EnvironmentObject var appState: AppState
//    @EnvironmentObject var sceneState: SceneState
//
//    var body: some View {
//        List(
//            appState.notes,
//            selection: $sceneState.selectedNoteId
//        ) { note in
//            NavigationLink(value: note.id) {
//                Text("Note \(note.id + 1)")
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                HStack {
//                    Button {
//                        let newNote = Note(text: "", id: appState.notes.count)
//                        appState.notes.append(newNote)
//                        sceneState.selectedNoteId = newNote.id
//                    } label: {
//                        Label("New Note", systemImage: "plus")
//                            .labelStyle(.titleAndIcon)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct NoteView: View {
//    @Binding var text: String
//
//    var body: some View {
//        TextEditor(text: $text)
//            .toolbar(id: "note") {
//                ToolbarItem(id: "favorite", placement: .secondaryAction) {
//                    FavoriteButton()
//                }
//                ToolbarItem(id: "tag", placement: .secondaryAction) {
//                    TagButton()
//                }
//                ToolbarItem(id: "image", placement: .secondaryAction) {
//                    ControlGroup {
//                        AddPhotoButton()
//                        AddDocumentScanButton()
//                    }
//                }
//                ToolbarItem(
//                    id: "Find", placement: .secondaryAction,
//                    showsByDefault: false
//                ) {
//                    FindButton()
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    ShareButton()
//                }
//            }
//            .toolbarRole(.editor)
//    }
//}
//
//struct ShareButton: View {
//    @EnvironmentObject var sceneState: SceneState
//    @EnvironmentObject var appState: AppState
//
//    var text: String {
//        if let selection = sceneState.selectedNoteId {
//            return appState.notes[selection].text
//        }
//        return ""
//    }
//
//    var body: some View {
//        ShareLink("Share", item: text)
//    }
//}
//
//struct FindButton: View {
//    var body: some View {
//        Button {
//            // show find and replace UI
//        } label: {
//            Label("Find and replace", systemImage: "magnifyingglass")
//        }
//    }
//}
//
//struct FavoriteButton: View {
//    var body: some View {
//        Button {
//            // add selected note to favorites
//        } label: {
//            Label("Favorite", systemImage: "star")
//        }
//    }
//}
//
//struct TagButton: View {
//    var body: some View {
//        Button {
//            // add a tag for selected note
//        } label: {
//            Label("Add Tag", systemImage: "number")
//        }
//    }
//}
//
//struct AddPhotoButton: View {
//    var body: some View {
//        Button {
//            // present photos picker UI
//        } label: {
//            Label("Choose Photo", systemImage: "photo.on.rectangle")
//        }
//    }
//}
//
//struct AddDocumentScanButton: View {
//    var body: some View {
//        Button {
//            // present document scanner UI
//        } label: {
//            Label("Scan Document", systemImage: "doc.viewfinder")
//        }
//    }
//}
//
//class SceneState: ObservableObject {
//    @Published var selectedNoteId: Int?
//}
//
//class AppState: ObservableObject {
//    @Published var notes: [Note] = []
//}
//
//struct Note: Identifiable {
//    var text: String
//    var id: Int
//    var tags: [String] = []
//}
//
//}
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
