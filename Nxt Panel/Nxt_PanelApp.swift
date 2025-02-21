import SwiftUI

@main
struct Nxt_PanelApp: App {
    @StateObject var loginScreenViewModel = LoginScreenViewModel.shared
    var body: some Scene {
        WindowGroup {
            if loginScreenViewModel.session == nil {
                LoginScreenView(loginScreenViewModel: loginScreenViewModel)
            } else {
                HomeView(loginScreenViewModel: loginScreenViewModel)
            }
        }
    }
}
