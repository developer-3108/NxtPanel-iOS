import SwiftUI

struct ReplyView: View {
    @ObservedObject var queryViewModel: QueryViewModel
    @State private var replyMessage: String = ""
    @State private var currentStatus: String = "Pending"
    
    @State private var currentStatusCategories: [String] = ["Pending", "In Progress", "Resolved", "Rejected", "Closed"]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Send a Reply")
                    .font(.title.bold())
                    .padding()
                
                HStack {
                   Text("Current Status:")
                    
                    Spacer()
                    
                    Picker("", selection: $currentStatus) {
                        ForEach(currentStatusCategories, id: \.self) { index in
                            Text(index)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
                
                TextEditor(text: $replyMessage)
                    .frame(minHeight: 100, maxHeight: 400)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                
                Button(
                    action: {
                    if let ticketID = queryViewModel.selectedQuery?.id {
                        queryViewModel.newStatus = currentStatus
                        
                        Task {
                            await queryViewModel.updateQueryStatus()
                            await queryViewModel
                                .postReply(
                                    ticketID: ticketID,
                                    adminID: "AdminID",
                                    message: replyMessage
                                )
                            DispatchQueue.main.async {
                                queryViewModel.isReplyViewPresent = false
                            }
                        }
                    }
                }) {
                    Text("Send Reply")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .onAppear {
                if let selectedQueryStatus = queryViewModel.selectedQuery?.status {
                    currentStatus = selectedQueryStatus
                }
            }
        }
    }
}

#Preview {
    ReplyView(queryViewModel: QueryViewModel())
}
