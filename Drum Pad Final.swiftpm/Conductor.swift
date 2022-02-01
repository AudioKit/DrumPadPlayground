import AudioKit
import AVFoundation
import Combine

class Conductor: ObservableObject {
    let engine = AudioEngine()
    let drums = AppleSampler()
    let delay: Delay
    let reverb: Reverb
    let mixer = Mixer()
    
    let drumSamples: [DrumSample] = 
    [
        DrumSample("HI TOM", file: "hi_tom_D2", note: 38),
        DrumSample("CRASH", file: "crash_F1", note: 29),
        DrumSample("HI HAT", file: "closed_hi_hat_F#1", note: 30),
        DrumSample("OPEN HI HAT", file: "open_hi_hat_A#1", note: 34),
        DrumSample("LO TOM", file: "mid_tom_B1", note: 35),
        DrumSample("CLAP", file: "clap_D#1", note: 27),
        DrumSample("KICK", file: "bass_drum_C1", note: 24),
        DrumSample("SNARE", file: "snare_D1", note: 26),
    ]
    
    var drumPadTouchCounts: [Int] = [] {
        willSet {
            for index in 0..<drumPadTouchCounts.count {
                if newValue[index] > drumPadTouchCounts[index] {
                    playPad(padNumber: index)
                }
            }
        }
    }
    
    @Published var mixerVolume: Float = 80 {
        didSet {
            mixer.volume = mixerVolume / 100.0
        }
    }
    
    @Published var reverbMix: Float = 5 {
        didSet {
            reverb.dryWetMix = reverbMix / 100.0
        }
    }
    
    @Published var reverbPreset: AVAudioUnitReverbPreset = .smallRoom {
        didSet {
            reverb.loadFactoryPreset(reverbPreset)
        }
    }
    
    @Published var delayMix: Float = 20 {
        didSet {
            delay.dryWetMix = delayMix
        }
    }
    
    @Published var delayFeedback: Float = 10 {
        didSet {
            delay.feedback = delayFeedback
        }
    }
    
    @Published var tempo: Float = 120.0 {
        didSet { updateDelayTime() }
    }
    
    @Published var delayDuration: MusicalDuration = .eighth {
        didSet { updateDelayTime() }
    }
    
    @Published var isDelayTimeMaxed: Bool = false
    
    func updateDelayTime() {
        let time = (60.0 / tempo) * Float(delayDuration.multiplier) * 4.0
        isDelayTimeMaxed = time > 2.0
        delay.time = time
    }
    
    init() {
        delay = Delay(drums)
        reverb = Reverb(delay)
        mixer.addInput(reverb)
        engine.output = mixer
        
        drumPadTouchCounts = Array(repeating: 0, count: drumSamples.count)
    }
    
    func start() {
        do {
            try engine.start() 
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        do {
            let files = drumSamples.compactMap { $0.audioFile }
            try drums.loadAudioFiles(files)
        } catch {
            Log("Could not load audio files \(error)")
        }
    }
    
    func playPad(padNumber: Int, velocity: Float = 1.0) {
        if !engine.avEngine.isRunning {
            start()
        }
        drums.play(noteNumber: MIDINoteNumber(drumSamples[padNumber].midiNote),
                   velocity: MIDIVelocity(velocity * 127.0))
    }
}

