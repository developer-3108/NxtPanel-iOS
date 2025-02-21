import SwiftUI

struct LoginScreenView: View {
    @ObservedObject var loginScreenViewModel: LoginScreenViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text("Let's get started")
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.title3)
                        
                        TextField("Enter email", text: $email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .font(.title2)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.title3)
                        
                        SecureField("Enter password", text: $password)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .font(.title2)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                            )
                    }
                    
                    Button {
                        loginScreenViewModel.email = email
                        loginScreenViewModel.password = password
                        
                        Task {
                            await loginScreenViewModel.login()
                            await loginScreenViewModel.checkUserSession()
                        }
                        
                    } label: {
                        Text("Submit")
                            .foregroundStyle(.white)
                            .frame(width: 170)
                            .padding()
                            .background(
                                email.isEmpty || password.isEmpty ? .gray
                                    .opacity(0.7)  : .red
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                }.padding(.horizontal)
                
                
            }
        }
    }
}

#Preview {
    LoginScreenView(loginScreenViewModel: LoginScreenViewModel.shared)
}
