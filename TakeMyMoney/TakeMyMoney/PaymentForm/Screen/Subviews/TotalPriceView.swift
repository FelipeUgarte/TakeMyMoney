import SwiftUI

struct TotalPriceView: View {
    let total: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Total price")
                    .font(.caption)

                Text("$\(total)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            Spacer()
        }
    }
}

struct TotalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalPriceView(total: "2.800,00")
    }
}
