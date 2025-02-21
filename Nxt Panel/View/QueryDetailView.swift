import SwiftUI

struct QueryDetailView: View {
    @ObservedObject var queryViewModel: QueryViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Text(queryViewModel.selectedQuery?.title ?? "N/A")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Button {
                        queryViewModel.isReplyViewPresent.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "return")
                            
                            Text("Reply")
                        }
                        .font(.subheadline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                        )
                        .foregroundStyle(Color.white)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Description:")
                        .font(.headline)
                    
                    Text("\(queryViewModel.selectedQuery?.description ?? "N/A")")
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Category:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(queryViewModel.selectedQuery?.category ?? "N/A")")
                            .font(.headline)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Priority:")
                            .font(.headline)
                        
                        Spacer()
                        
                        if queryViewModel.selectedQuery?.priority == "Low" {
                            Text("\(queryViewModel.selectedQuery?.priority ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.green)
                        } else if queryViewModel.selectedQuery?.priority == "Medium" {
                            Text("\(queryViewModel.selectedQuery?.priority ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.yellow)
                        } else if queryViewModel.selectedQuery?.priority == "High" {
                            Text("\(queryViewModel.selectedQuery?.priority ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.orange)
                        } else if queryViewModel.selectedQuery?.priority == "Urgent" {
                            Text("\(queryViewModel.selectedQuery?.priority ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Current Status:")
                            .font(.headline)
                        
                        Spacer()
                        
                        if queryViewModel.selectedQuery?.status == "Pending" {
                            Text("\(queryViewModel.selectedQuery?.status ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.orange)
                        } else if queryViewModel.selectedQuery?.status == "In Progress" {
                            Text("\(queryViewModel.selectedQuery?.status ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.orange)
                        } else if queryViewModel.selectedQuery?.status == "Resolved" {
                            Text("\(queryViewModel.selectedQuery?.status ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.green)
                        } else if queryViewModel.selectedQuery?.status == "Rejected" {
                            Text("\(queryViewModel.selectedQuery?.status ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                        } else if queryViewModel.selectedQuery?.status == "Closed" {
                            Text("\(queryViewModel.selectedQuery?.status ?? "N/A")")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Device Name:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(queryViewModel.selectedQuery?.device_name ?? "N/A")")
                            .font(.headline)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Device Model:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(queryViewModel.selectedQuery?.device_model ?? "N/A")")
                            .font(.headline)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("System Name:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(queryViewModel.selectedQuery?.system_name ?? "N/A")")
                            .font(.headline)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("System Version:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(queryViewModel.selectedQuery?.system_version ?? "N/A")")
                            .font(.headline)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Replies")
                            .font(.headline.bold())
                        
                        Spacer()
                    }
                    
                    if queryViewModel.replies.isEmpty {
                        VStack {
                            Text("No replies yet.")
                                .foregroundColor(.gray)
                                .italic()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(queryViewModel.replies) { reply in
                            if reply.sender_type == "admin" {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text(reply.reply_message)
                                            .font(.title3)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(reply.created_at)
                                            .font(.subheadline)
                                            .foregroundStyle(
                                                Color.gray.opacity(0.7)
                                            )
                                            .italic()
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .trailing)
                                    }
                                    .padding()
                                    .frame(width: 300, alignment: .leading)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                Color.blue.opacity(0.2)
                                            )
                                    }
                                    
                                }
                            } else if reply.sender_type == "user" {
                                HStack {
                                    Image("avatar")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading) {
                                        Text(reply.reply_message)
                                            .font(.title3)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(reply.created_at)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.gray.opacity(0.7))
                                            .italic()
                                    }
                                    .padding()
                                    .frame(width: 300, alignment: .leading)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                Color.gray.opacity(0.2)
                                            )
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
            }
            .sheet(isPresented: $queryViewModel.isReplyViewPresent, content: {
                ReplyView(queryViewModel: queryViewModel)
            })
            .onAppear {
                if let query = queryViewModel.selectedQuery {
                    queryViewModel.fetchReplies(for: query.id)
                }
            }
            .padding(.horizontal)
        }.refreshable {
            queryViewModel.fetchReplies(for: queryViewModel.selectedQuery!.id)
        }
    }
}

#Preview {
    QueryDetailView(queryViewModel: QueryViewModel())
}
