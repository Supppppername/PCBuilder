

import SwiftUI

struct AddPartsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var manageObjectContext
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var component: String = "CPU"
    
    let components = ["CPU", "GPU", "PSU", "RAM", "Motherboard", "Storage", "Case"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TODO NAME
                    TextField("Name", text: $name)
                    TextField("Price", text: $price)
                    
                    // MARK: - TODO PARTS
                    Picker("Component", selection: $component) {
                        ForEach(components, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        if self.name != "" && self.price != "" && self.price.isnumberordouble {
                            let part = Part(context: self.manageObjectContext)
                            part.name = self.name
                            part.price = self.price
                            part.component = self.component
                            
                            do {
                                try self.manageObjectContext.save()
                                print("New part: \(part.name ?? ""),Component: \(part.component ?? ""),Price: \(part.price ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Input"
                            self.errorMessage = "Empty input or invalid price"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                            Text("Save")
                        } //: SAVE BUTTON
                } //: FORM
                Spacer()
            } //: VSTACT
            .navigationBarTitle("New Part", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "xmark")
            }
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
        
    }
}

struct Previews_AddPartsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
