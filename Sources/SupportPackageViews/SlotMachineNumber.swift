import SwiftUI

/// Support animated number display up to 999
public struct SlotMachineNumber: View {
    
    class AnimationModel: ObservableObject {
        @Published var currentNumber = 0
        var targetNumber = 0 {
            didSet {
                currentNumber = 0
                timer = Timer.scheduledTimer(withTimeInterval: 1 / Double(numbersPerSecond), repeats: true) { [weak self] _ in
                    guard let self else { return }
                    if self.currentNumber < self.targetNumber {
                        self.currentNumber += 1
                    } else {
                        self.timer?.invalidate()
                        self.timer = nil
                    }
                }
            }
        }
        var numbersPerSecond = 0
        private var timer: Timer?
        
        var hundreds: String? {
            guard targetNumber / 100 > 0 else { return nil }
            return numberToStringSpacebarZero(currentNumber / 100)
        }
        
        var tens: String? {
            guard targetNumber / 10 > 0 else { return nil }
            let tens = (currentNumber / 10) % 10
            return currentNumber >= 10 ? "\(tens)" : numberToStringSpacebarZero(tens)
        }
        
        var units: String {
            "\(currentNumber % 10)"
        }
        
        private func numberToStringSpacebarZero(_ number: Int) -> String {
            number == 0 ? " " : "\(number)"
        }
    }
    
    @StateObject private var animationModel = AnimationModel()
    public let textSize = 20.0
    public let number: Int
    public let numbersPerSecond = 60
    
    public var body: some View {
        HStack(spacing: 1) {
            if let hundreds = animationModel.hundreds {
                digit(hundreds, idPrefix: "hundreds")
            }
            if let tens = animationModel.tens {
                digit(tens, idPrefix: "tens")
            }
            digit(animationModel.units, idPrefix: "units")
        }
        .onAppear {
            animationModel.numbersPerSecond = numbersPerSecond
            animationModel.targetNumber = number
        }
    }
    
    private func digit(_ content: String, idPrefix: String) -> some View {
        SwiftUI.Text(content)
            .font(.system(size: textSize))
            .id(idPrefix + content)
            .transition(.move(edge: .top).combined(with: .opacity))
    }

    
}


#Preview {
    SlotMachineNumber(number: 46)
}
