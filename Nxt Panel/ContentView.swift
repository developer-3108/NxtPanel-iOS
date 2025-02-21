import SwiftUI

struct ContentView: View {
    @ObservedObject var loginScreenViewModel: LoginScreenViewModel
    var body: some View {
        LoginScreenView(loginScreenViewModel: loginScreenViewModel)
    }
}

#Preview {
    ContentView(loginScreenViewModel: LoginScreenViewModel.shared)
}
