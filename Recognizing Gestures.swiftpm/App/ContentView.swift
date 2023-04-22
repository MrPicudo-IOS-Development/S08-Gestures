/* ContentView.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Vista principal, que se carga al iniciar la app.
struct ContentView: View {
    // Vamos directamente a la vista.
    var body: some View {
        // Usamos un NavigationSplitView
        NavigationSplitView {
            // Creamos una lista de NavigationLinks que tienen objetos de la estructura de tipo vista "GestureRow"
            List {
                NavigationLink(destination: TapView()) {
                    GestureRow(title: "Tap", description: "Tap a shape to interact with it.", systemImage: "hand.point.up.left")
                }
                NavigationLink(destination: LongPressView()) {
                    GestureRow(title: "Touch and Hold", description: "Touch and hold a shape to interact with it.", systemImage: "hand.tap")
                }
                NavigationLink(destination: DragView()) {
                    GestureRow(title: "Drag", description: "Drag a shape using one finger.", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                }
                NavigationLink(destination: RotateView()) {
                    GestureRow(title: "Rotate", description: "Rotate a shape with two fingers.", systemImage: "arrow.triangle.2.circlepath")
                }
                NavigationLink(destination: SingleLine()) {
                    GestureRow(title: "Line Drawing", description: "Use your finger to draw a simple line shape.", systemImage: "pencil.tip")
                }
            }
            .navigationTitle("Gestures")
        } detail: {
            Text("Select a Gesture Example")
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
