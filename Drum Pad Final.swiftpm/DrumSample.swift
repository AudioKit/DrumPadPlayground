import AVFoundation

struct DrumSample {
    var name: String
    var fileName: String
    var midiNote: Int
    var audioFile: AVAudioFile?
    
    init(_ displayName: String, file: String, note: Int) {
        name = displayName
        fileName = file
        midiNote = note
        
        guard let url = Bundle.main.url(forResource: file, withExtension: "wav") else {
            print("Could not find: \(file)")
            return
        }
        
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Could not load: \(url)")
        }
    }
}

