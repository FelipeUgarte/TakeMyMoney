import SwiftUI

struct PaymentButton: View {
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text("Proceed to confirm")
                .padding()
        }.buttonStyle(.borderedProminent)
    }
}

struct PaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButton(action: {})
    }
}
