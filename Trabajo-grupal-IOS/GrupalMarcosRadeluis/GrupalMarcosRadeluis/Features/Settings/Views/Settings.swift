import SwiftUI
import AVKit

struct Sound: Identifiable, Hashable, Codable {
    var name: String
    var id: Int
}

struct Settings: View {
    let sounds: [Sound] = [
        Sound(name: "bidibun", id: 1005),
        Sound(name: "banban", id: 1006),
        Sound(name: "rinquitin", id: 1007),
        Sound(name: "tarara", id: 1008)
    ]
    
    @State private var selectedSound: Sound?
    @State private var didError = false
    @State private var playSound = false
    
    private var settings = UserDefaultsUtils.appSettings
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            Form {
                Picker("Alert sound:", selection: $selectedSound) {
                    ForEach(sounds, id: \.self) { sound in
                        Text(sound.name.capitalized).tag(sound as Sound?)
                    }
                }
                .onChange(of: selectedSound) {
                    if let soundID = selectedSound?.id {
                        if playSound {
                            let oldSoundId = settings?.alertSoundId
                            settings?.alertSoundId = soundID
                            let isSaved = UserDefaultsUtils.saveSettings(settings!)
                            
                            if (isSaved) {
                                AudioServicesPlayAlertSound( UInt32(soundID) )
                            }else{
                                didError = true
                                selectedSound = sounds
                                    .first( where:{ $0.id == oldSoundId } )
                            }
                        }
                        playSound = true
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
            .alert(
                "Oop!",
                isPresented: $didError
            ) {
            } message: {
                Text("There was an error saving")
            }
        }
        .onAppear{
            playSound = false
            self.selectedSound = sounds.first( where: {$0.id == self.settings?.alertSoundId})
        }
    }
}

#Preview {
    Settings()
}
