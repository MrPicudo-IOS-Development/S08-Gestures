/* TapView.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Cambia aleatoriamente el color de un rectángulo cada vez que presionamos sobre él.
struct TapView: View {

    // Variable de estado para cambiar el color.
    @State private var color : Color = Color.primary
    
    // Definimos un gesto personalizado, que podemos usar en cualquier objeto de vista con la propiedad .gesture()
    var tapGesture: some Gesture {
        TapGesture() // Es un gesto de tipo Tap
            .onEnded { // Que se activa al terminar el Tap
                withAnimation { // Con un modo "animación"
                    color = Color.random() // Modifica de manera aleatoria el color, con una función agregada en una extensión.
                }
            }
    }
    
    // Vista de la estructura TapView.
    var body: some View {
        VStack {
            Text("Tap the rectangle to change its color")
            Spacer() // Recordemos los spacers para unn buen diseño
            // Rectángulo con propiedades de color, tamaño y gestos.
            Rectangle()
                .foregroundColor(color)
                .frame(width: 250, height: 450)
                .gesture(tapGesture) // Con la propiedad .gesture de un objeto en la vista, se puede modificar un atributo definido en una variable de tipo "some Gesture".
            Spacer()
        }
        .navigationTitle("Tap") // Título del VStack
        .padding()
        .toolbar { // Hay una barra de herramientas en los VStack que podemos utilizar y se crea algo profesional de manera fácil.
            Button("Reset") {
                color = Color.primary
            }
        }
    }
}

// Vista previa de la estructura.
struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}

// Agregamos una extensión a la clase Color, en donde definimos un color aleatorio en rgb con valores Double.random(in: 0...1)
extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}


/* Orden de la estructura TapView:
    1) imports
    2) struct TapView
    3) state variables
    4) variables (Some Gesture)
    5) body
    6) preview
    7) extension
 */
