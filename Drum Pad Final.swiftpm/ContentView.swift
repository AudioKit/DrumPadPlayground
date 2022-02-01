import SwiftUI
import AudioKitUI

struct ContentView: View {
    @EnvironmentObject var conductor: Conductor
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
                                    ArcKnob(value: $conductor.delayMix, 
                                            range: 0...100, 
                                            title: "DELAY MIX", 
                                            textColor: Color("textColor1"), 
                                            arcColor: Color("knobFill"))
                                    ArcKnob(value: $conductor.delayFeedback,
                                            range: 0...100, title: "FEEDBACK",
                                            textColor: Color("textColor1"),
                                            arcColor: Color("knobFill"))
                                }
                                MusicalDurationStepper(musicalDuration: $conductor.delayDuration, time: conductor.delay.time)
                                    .padding(.leading, padding / 2)
                                    .frame(height: stepperHeight)
                                    .foregroundColor(Color("textColor2"))
                                    .frame(minWidth: 200)
                            }
                            Spacer()
                            VStack {
                                HStack {
                                    ArcKnob(value: $conductor.reverbMix,
                                            range: 0...100, title: "REVERB",
                                            textColor: Color("textColor1"),
                                            arcColor: Color("knobFill"))
                                    ArcKnob(value: $conductor.mixerVolume,
                                            range: 0...100, title: "VOLUME",
                                            textColor: Color("textColor1"),
                                            arcColor: Color("knobFill"))
                                }
                                ReverbPresetStepper(preset: $conductor.reverbPreset)
                                    .padding(.trailing, padding / 2)
                                    .frame(height: stepperHeight)
                                    .foregroundColor(Color("textColor2"))
                                    .frame(minWidth: 200)
                            }
                        }.padding(.bottom, padding / 2)
                    }.frame(minWidth: 450)
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(.black)
                        NodeOutputView(conductor.mixer).padding(padding)
                    }
                }.frame(height: controlsHeight)
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color("controlsBackground"))
                    HStack {
                        TempoDraggableStepper(tempo: $conductor.tempo)
                            .foregroundColor(Color("textColor1")).frame(width: 200)
                        Spacer()
                        if conductor.isDelayTimeMaxed {
                            Text("WARNING: DELAY TIME IS TOO LONG!")
                                .font(Font.system(size: 20, weight: .bold))
                                .foregroundColor(.red)
                        } else {
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
                    }
                    .padding(8)


                }.frame(height: 30)

                TapCountingDrumPadGrid(names: conductor.drumSamples.map { $0.name }) { tapCounts in
                    conductor.drumPadTouchCounts = tapCounts
                }
                
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
                .environmentObject(Conductor())
            ContentView()
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.landscapeLeft)
                .environmentObject(Conductor())
        }
    }
}
