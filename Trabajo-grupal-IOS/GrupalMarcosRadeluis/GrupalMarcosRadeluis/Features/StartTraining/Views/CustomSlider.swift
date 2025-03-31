//
//  Slider.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 11/1/25.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 0.0
    var maxValue = 100.0
    var thumbColor: UIColor = UIColor(named: "ButtonColor")!
    var minTrackColor: UIColor = .clear
    var maxTrackColor: UIColor = .clear
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor =  maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.isUserInteractionEnabled = false
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        UIView.animate(withDuration: 0.9, animations: {
            uiView.setValue(Float(value), animated: true)
        })
    }
}

struct CustomSlider: View {
    
    @Binding var value: Double
    
    var body: some View {
        VStack {
            UISliderView(value: $value)
                .background(
                    LinearGradient(gradient: Gradient(colors: [
                        Color.green,
                        Color.green.opacity(0.7),
                        Color.yellow,
                        Color.orange,
                        Color.red
                    ]), startPoint: .leading, endPoint: .trailing)
                    .cornerRadius(10)
                    .frame(height: 20)
                )
            
            Text("Intensity")
                .font(.title3)
                .scaledToFit()
                .foregroundColor(Color("DisabledColor"))
        }
    }
}

#Preview {
    CustomSlider(value: .constant(85))
}
