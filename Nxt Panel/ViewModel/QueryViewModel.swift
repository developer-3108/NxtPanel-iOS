import Foundation
import Supabase

class QueryViewModel: ObservableObject {
    @Published var queries: [Query] = []
    @Published var selectedQuery: Query? = nil
    @Published var isReplyViewPresent: Bool = false
    @Published var replies: [Reply] = []
    @Published var newStatus: String = ""
    
    func fetchQueries() async {
        print("Fetching queries...")
        Task {
            do {
                let fetchedQueries: [Query] = try await supabase.database
                    .from("query_tickets")
                    .select()
                    .execute()
                    .value
                
                DispatchQueue.main.async {
                    self.queries = fetchedQueries
                    print("Queries updated!")
                }
            } catch {
                print("Error fetching queries: \(error)")
            }
        }
    }
    
    func updateQueryStatus() async {
        guard let queryID = selectedQuery?.id, !queryID.isEmpty else {
            print("Error: Selected query ID is nil or empty")
            return
        }
        
        do {
            print("Updating status for ticketID: \(queryID) with status: \(newStatus)")
            
            try await supabase.database
                .from("query_tickets")
                .update(["status": newStatus])
                .eq("id", value: queryID)
                .execute()
            
            print("Query status updated successfully")
            
            await fetchQueries()
            
        } catch {
            print("Error updating query status: \(error)")
        }
    }
    
    func fetchReplies(for ticketID: String) {
        print("Fetching replies for ticketID: \(ticketID)")
        Task {
            do {
                let fetchedReplies: [Reply] = try await supabase.database
                    .from("query_reply")
                    .select()
                    .eq("ticket_id", value: ticketID)
                    .order("created_at", ascending: false)
                    .execute()
                    .value
                
                DispatchQueue.main.async {
                    self.replies = fetchedReplies
                }
                
                
                
            } catch {
                print("Error fetching replies: \(error)")
            }
        }
    }
    
    func postReply(ticketID: String, adminID: String, message: String) async {
        Task {
            do {
                guard let session = try? await supabase.auth.session else {
                    print("User session not found. Maybe not logged in?")
                    return
                }
                
                guard let userUUID = UUID(uuidString: session.user.id.uuidString),
                      let ticketUUID = UUID(uuidString: ticketID) else {
                    print("Invalid UUID conversion")
                    return
                }
                
                let userID = session.user.id
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" 
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
                let formattedDate = dateFormatter.string(from: Date())
                
                let newReply = Reply(
                    id: UUID(),
                    ticket_id: ticketUUID,
                    admin_id: userID,
                    reply_message: message,
                    created_at: formattedDate,
                    user_id: nil,
                    sender_type: "admin"
                )
                
                try await supabase.database
                    .from("query_reply")
                    .insert(newReply)
                    .execute()
                
                fetchReplies(for: ticketID)
                
            } catch {
                print("Error posting reply: \(error)")
            }
        }
    }
    
}
