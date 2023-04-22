/* DragView.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Muestra un circulo desplazable sobre la interfaz. La posición para arrastrar algo se ubica en la esquina superior izquierda, que sería como la posición cero,cero.
struct DragView: View {
    
    // Constante que almacena el tamaño del objeto que vamos a desplazar (un círculo)
    private let circleSize: CGFloat = 100
    
    // Variable de estado que almacena el valor del desplazamiento del objeto, y se inicializa en cero, con la propiedad .zero del CGSize.
    @State private var offset = CGSize.zero // Recordemos que los CGSize almacenan dos valores distintos de tamaño o posición. En este caso se usa como las componentes de un vector.
    
    // Gesto personalizado para indicar qué sucede cada vez que usamos el DragGesture.
    var dragGesture: some Gesture {
        DragGesture() // Es de tipo DragGesture
            .onChanged { value in // Se activa cada vez que un "value" cambia. Esto de .onChange es un event handler.
                // .startLocation y .translation son atributos del DragGesture, que se controlan mediante "eventos"
                offset = CGSize(width: value.startLocation.x + value.translation.width - circleSize/2,
                                height: value.startLocation.y + value.translation.height - circleSize/2)
            }
    }

    // Vista de la estructura "DragView"
    var body: some View {
        VStack {
            Text("Use one finger to drag the circle around")
            Spacer() // Otra vez un spacer() para darle formato a una vista después de mostrar instrucciones
            Circle()
                .foregroundColor(.teal)
                .frame(width: circleSize, height: circleSize)
                .offset(offset) // La propiedad offset nos sirve para desplazar una vista con respecto a su posición inicial.
                .gesture(dragGesture) // Y aún así, debemos de activar el gesto con el modificador .gesture()
            Spacer()
        }
        .navigationTitle("Drag") // Título del VStack.
        .padding()
        .toolbar { // Agregamos a las herramientas del VStack un botón que reinicia la posición del objeto desplazable.
            Button("Reset") {
                offset = .zero
            }
        }
    }
}

// Vista previa de la estructura DragView
struct DragView_Previews: PreviewProvider {
    static var previews: some View {
        DragView()
    }
}
