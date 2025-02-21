import SwiftUI

struct HomeView: View {
    @ObservedObject var loginScreenViewModel: LoginScreenViewModel
    @StateObject var queryViewModel = QueryViewModel()
    var body: some View {
        NavigationStack {
            
            Button {
                Task {
                    await loginScreenViewModel.signOut()
                }
            } label: {
                Text("Sign Out")
            }
            
            ScrollView {
                allQuery(queryViewModel: queryViewModel)
                
                
                
                
            }.onAppear {
                Task {
                     await queryViewModel.fetchQueries()
                }
            }
        }
    }
}

struct allQuery: View {
    @ObservedObject var queryViewModel: QueryViewModel
    var body: some View {
        VStack {
            if !queryViewModel.queries.isEmpty {
                VStack {
                    ForEach(queryViewModel.queries.reversed()) { query in
                        Button {
                            queryViewModel.selectedQuery = query
                        } label: {
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text(query.title)
                                        .font(.title3.bold())
                                        .foregroundStyle(Color.black)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    if query.status == "Pending" {
                                        Text(query.status)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.orange)
                                    } else if query.status == "In Progress" {
                                        Text(query.status)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.orange)
                                    } else if query.status == "Resolved" {
                                        Text(query.status)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.green)
                                    } else if query.status == "Rejected" {
                                        Text(query.status)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.red)
                                    } else if query.status == "Closed" {
                                        Text(query.status)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.red)
                                    }
                                    
                                }
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Ticket Id: \(query.id)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.gray.opacity(0.7))
                                }
                            }.padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                .shadow(radius: 10)
                                .padding(.horizontal)
                        }
                    }
                }
                NavigationLink(
                    destination: QueryDetailView(queryViewModel: queryViewModel),
                    isActive: Binding(
                        get: { queryViewModel.selectedQuery != nil },
                        set: { if !$0 { queryViewModel.selectedQuery = nil } }
                    )
                ) {
                    EmptyView()
                }
                
            } else {
                Text("You don't have any queries")
                    .font(.headline)
                    .foregroundStyle(Color.gray.opacity(0.7))
            }
        }
    }
}


#Preview {
    HomeView(loginScreenViewModel: LoginScreenViewModel.shared)
}
