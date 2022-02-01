import SwiftUI

@main
struct DrumPadAppApp: App {
    
    let conductor = Conductor()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(conductor)
        }
    }
}
