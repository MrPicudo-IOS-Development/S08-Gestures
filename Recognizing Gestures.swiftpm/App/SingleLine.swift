/* SingleLine.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Nos permite crear líneas en la interfaz con el gesto Drag.
struct SingleLine: View {
    // Variables de estado que almacenan la posición inicial y final de la línea.
    @State var lineStart = CGPoint.zero
    @State var lineEnd = CGPoint.zero
    
    // Gesto PERSONALIZADO (con nombre y todo), que podemos usar en el modificador .gesture de cualquier objeto de vista.
    var lineDrawingGesture: some Gesture {
        DragGesture() // Es de tipo DragGesture
            .onChanged { value in // Cuando estamos haciendo el gesto se guarda únicamente el valor de inicio.
                lineStart = value.startLocation
                lineEnd = value.location // Y se muestra cómo el valor final se puede modificar con el gesto.
            }
            .onEnded { value in // Pero al finalizar el gesto, se guarda el valor final, en donde nos hayamos quedado.
                lineEnd = value.location
            }
    }
    
    // Vista de la estructura "SingleLine"
    var body: some View {
        VStack {
            Text("Touch and drag to make a line")
            Spacer()
            // La línea realmente es un Path.
            Path { path in
                path.move(to: lineStart)
                path.addLine(to: lineEnd)
            }
            .stroke(Color.purple, lineWidth: 8.0)
            .contentShape(Rectangle())
            .gesture(lineDrawingGesture)
        }
        .navigationTitle("Line Drawing")
        .padding()
        .toolbar {
            Button("Reset") {
                lineStart = .zero
                lineEnd = .zero
            }
        }
    }
}

// Vista previa.
struct SingleLine_Previews: PreviewProvider {
    static var previews: some View {
        SingleLine()
    }
}
