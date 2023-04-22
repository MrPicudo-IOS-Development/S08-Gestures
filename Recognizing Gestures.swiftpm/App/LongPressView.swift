/* LongPressView.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Modifica el tamaño de una cápsula cada vez que la tocamos y mantenemos el gesto.
struct LongPressView: View {
    
    // Variable de estado que controla el índice del arreglo sizes. Para controlar un array con una State var, basta con dejar el array como una variable normal, y crear un @State var para el índice del arreglo.
    @State private var sizeIndex = 0
    
    // Arreglo de tamaños con la estructura CGSize, que sirve precisamente para almacenar valores de width y height.
    private var sizes: [CGSize] = [
        CGSize(width: 150, height: 80),
        CGSize(width: Int.random(in: 20...400), height: Int.random(in: 20...400)),
        CGSize(width: 200, height: 40),
        CGSize(width: Int.random(in: 20...400), height: Int.random(in: 20...400)),
        CGSize(width: 50, height: 250),
        CGSize(width: Int.random(in: 20...400), height: Int.random(in: 20...400)),
        CGSize(width: 220, height: 100),
        CGSize(width: Int.random(in: 20...400), height: Int.random(in: 20...400)),
        CGSize(width: 90, height: 90),
        CGSize(width: 376, height: 192),
        CGSize(width: 107, height: 332),
        CGSize(width: 345, height: 267),
        CGSize(width: 80, height: 397),
        CGSize(width: 280, height: 65),
        CGSize(width: 138, height: 300),
        CGSize(width: 48, height: 125),
        CGSize(width: 391, height: 351),
        CGSize(width: 166, height: 154),
        CGSize(width: 320, height: 215),
        CGSize(width: 67, height: 284),
        CGSize(width: 293, height: 390),
        CGSize(width: 188, height: 58),
        CGSize(width: 400, height: 183),
        CGSize(width: 112, height: 319)
    ]
    
    // Definimos otro gesto personalizado que podemos usar en cualquier objeto de vista con la propiedad .gesture()
    var longPressGesture: some Gesture {
        LongPressGesture() // Se activa con un LongPressGesture.
            .onEnded { value in // Al final del gesto
                withAnimation { // Con una animacion
                    sizeIndex += 1
                    if sizeIndex == sizes.count { // Reiniciamos la variable de estado iterativa que pasa por todos los elementos del arreglo sizes.
                        sizeIndex = 0
                    }
                }
            }
    }
    
    // Vista de la estructura LongPressView
    var body: some View {
        VStack {
            Text("Touch and hold the capsule to change its size")
            Spacer() // Nuevamente, es buena idea usar spacers después de un texto de instrucciones en la app.
            // Objeto de tipo Capsule, que me imagino es como un rectángulo con bordes redondeados.
            Capsule()
                .foregroundColor(.yellow)
                .frame(width: sizes[sizeIndex].width, height: sizes[sizeIndex].height) // Modificamos los atributos de ancho y alto con los valores del arreglo.
                .gesture(longPressGesture) // Para que se reconozca el gesto sobre este objeto, necesitamos agregarlo a la propiedad .gesture()
            Spacer()
        }
        .navigationTitle("Touch and Hold")
        .padding()
        .toolbar {
            Button("Reset") {
                sizeIndex = 0
            }
        }
    }
}

// Vista previa de la estructura LongPressView.
struct LongPressView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressView()
    }
}
