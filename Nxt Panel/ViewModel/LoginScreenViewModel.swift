import Foundation
import Supabase

@MainActor
class LoginScreenViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    static let shared = LoginScreenViewModel()
    @Published var session: Session?
    
    private init() {
        Task {
            await checkUserSession()
        }
    }
    
    func login() async {
        do {
            try await supabase.auth.signIn(email: email, password: password)
            
            let user = try await supabase.auth.session.user
            print("User Metadata:", user.userMetadata)
            
            if let roleJSON = user.userMetadata["role"],
               let roleString = roleJSON.stringValue {
                print("Role Found: \(roleString)")
                
                if roleString == "admin" {
                    print("✅ Admin logged in! Access Granted.")
                    session = try await supabase.auth.session
                } else {
                    print("❌ Access Denied! Normal users cannot access admin panel.")
                    
                    await signOut()
                }
            } else {
                print("🚫 No role found in metadata. Logging out user.")
                await signOut()
            }
            
        } catch {
            print("❌ Login Error: \(error.localizedDescription)")
        }
    }
    
    func checkUserSession() async {
        do {
            session =  try await supabase.auth.session
            print("Uses Session: \(String(describing: session))")
        } catch {
            print("\(error.localizedDescription)")
            session = nil
        }
    }
    
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            session = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
