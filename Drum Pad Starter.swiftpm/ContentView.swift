import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL

    let padding: CGFloat = 30
    let cornerRadius: CGFloat = 15
    let spacing: CGFloat = 20
    let controlsHeight: CGFloat = 200
    let stepperHeight: CGFloat = 40

    var body: some View {

        ZStack {
            Color("background")

            VStack(spacing: spacing) {
                Image("header").resizable().scaledToFit().frame(height: 24)
                HStack(spacing: spacing) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color("controlsBackground"))
                        HStack {
                            VStack {
                                HStack {
                                    // Delay Knobs go here
                                }
                                // Musical Duration Stepper goes here
                            }
                            Spacer()
                            VStack {
                                HStack {
                                    // Reverb and volume knobs go here
                                }
                                // Reverb Preset Stepper goes here
                            }
                        }.padding(.bottom, padding / 2)
                    }.frame(minWidth: 450)
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(.black)
                        // Node Output View goes here
                    }
                }.frame(height: controlsHeight)
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color("controlsBackground"))
                    HStack {
                        // Tempo Draggable Stepper goes here
                        Spacer()
                        Text("MAKE THIS APP ON YOUR IPAD")
                            .foregroundColor( Color("textColor1"))
                            .font(Font.system(size: 18))
                        Button(action: {
                            openURL(URL(string: "https://audiokitpro.com/drumpadplayground/")!)
                        }) {
                            Text("WATCH TUTORIAL")
                                .foregroundColor(Color("textColor1"))
                                .fontWeight(.semibold)
                                .font(Font.system(size: 18))
                        }.foregroundColor(.white)
                            .padding(.horizontal, 10.0)
                            .padding(.vertical, 5.0)
                            .background(Color("buttonBackground"))
                            .cornerRadius(10.0)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.6), lineWidth: 1))
                }
                    .padding(8)


                }.frame(height: 30)

                // Drum pads go here
                
            }.padding(padding)
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.landscapeLeft)
            ContentView()
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
