/* *** *** *** REFERENCE *** *** *** */
/*

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



/* GestureRow.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

/// Estructura de vista, que usamos como modelo para crear todas las filas de la lista de gestos para la aplicación.
struct GestureRow: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .frame(width: 30)
                .font(.title)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                Text(description)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(10)
        }
    }
}

struct GestureRow_Previews: PreviewProvider {
    static var previews: some View {
        GestureRow(title: "Drag", description: "Drag a shape using one finger", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
    }
}



/* GesturesApp.swift --> Recognizing Gestures. 22/04/2023 */

import SwiftUI

@main
/// Estructura principal que inicia toda la aplicación.
struct GesturesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



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


*/
