
import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var manageObjectContext
    
    @FetchRequest(entity: Part.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Part.name, ascending: true)]) var parts: FetchedResults<Part>
    
    @State private var showingAddPartsView: Bool = false
    @State private var total: Double = 0
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            ZStack {
                List {
                    ForEach(self.parts, id: \.self) {
                        part in
                        HStack {
                            Text(part.name ?? "Unknown")
                            Spacer()
                            Text("$\(part.price ?? "Unkown")")
                            Spacer()
                            Text(part.component ?? "Unknown")
                        }
                    } //: FOREACH
                    .onDelete(perform: deletePart)
                } //: LIST
                .navigationBarTitle("Components", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                    self.showingAddPartsView.toggle()
                    }) {
                    Image (systemName: "plus")
                    } //: ADD BUTTON
                    .sheet(isPresented: $showingAddPartsView) {
                        AddPartsView().environment(\.managedObjectContext, self.manageObjectContext)
                    }
                )
                
                // MARK: - NO PARTS
                if parts.count == 0 {
                    Text("Add something to start!")
                }
                
            } //: ZSTACK
        } //: NAVIGATIONVIEW
    }
    
    // MARK: - FUNCTIONS
    private func deletePart(at offsets: IndexSet) {
        for index in offsets {
            let part = parts[index]
            manageObjectContext.delete(part)
            do {
                try manageObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    


}
