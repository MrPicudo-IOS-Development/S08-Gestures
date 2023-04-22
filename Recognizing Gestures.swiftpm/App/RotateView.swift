/* RotateView.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Nos permite rotar un cuadrado usando dos dedos para seleccionarlo y girarlo. En el simulador esto se puede hacer dejando presionada la tecla option.
struct RotateView: View {
    
    // Variable de estado que almacena el valor del ángulo de rotación del objeto. Se usa la clase Angle.
    @State private var rotation = Angle.zero
    
    // Gesto personalizado que podemos utilizar dentro del modificador .gesture() de cualquier objeto de vista.
    var rotationGesture: some Gesture {
        RotationGesture() // Es de tipo RotationGesture()
            .onChanged{ angle in // Se activa usando el event handler ".onChanged", cada vez que cambia su valor (mientras lo giramos)
                rotation = angle
            }
            .onEnded { angle in // Y se deja en la posición indicada al terminar el gesto (cuando dejamos de girarlo)
                rotation = angle
            }
    }
    
    // Vista de la estructura RotateView.
    var body: some View {
        VStack {
            Text("Use two fingers to rotate the box")
            Spacer()
            Rectangle()
                .foregroundColor(.red)
                .frame(width: 225, height: 225)
                .rotationEffect(rotation) // Para que funcione el gesto, debemos de pasar el ángulo al modificador .rotationEffect() del objeto que vamos a girar.
                .gesture(rotationGesture) // Y activar el gesto en el modificador .gesture()
            Spacer()
        }
        .navigationTitle("Rotate") // Título del VStack
        .padding()
        .toolbar { // Agregamos un botón a la barra de herramientas del VStack, que va hasta arriba a la derecha.
            Button("Reset") {
                rotation = .zero
            }
        }
    }
}

// Vista previa.
struct RotateView_Previews: PreviewProvider {
    static var previews: some View {
        RotateView()
    }
}
