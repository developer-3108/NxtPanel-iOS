import Foundation
import Supabase

struct Query: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let category: String
    let priority: String
    let device_name: String
    let device_model: String
    let system_name: String
    let system_version: String
    var status: String
}

struct Reply: Codable, Identifiable {
    let id: UUID
    let ticket_id: UUID
    let admin_id: UUID?
    let reply_message: String
    let created_at: String
    let user_id: UUID?
    let sender_type: String
}
