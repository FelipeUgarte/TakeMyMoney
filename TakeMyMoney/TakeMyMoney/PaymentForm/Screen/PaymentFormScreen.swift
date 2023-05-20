import SwiftUI

struct PaymentFormScreen: View {
    @StateObject var viewModel = PaymentFormViewModel()

    var body: some View {
        NavigationStack {
            PaymentFormView(selectedMethod: $viewModel.selectedPaymentMethod,
                            total: viewModel.shoppingCart.total,
                            methods: viewModel.paymentData.paymentMethods)
            PaymentButton(action: viewModel.purchaseButtonAction)
                .navigationTitle("Payment data")
        }
    }
}

struct PaymentFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFormScreen()
    }
}
