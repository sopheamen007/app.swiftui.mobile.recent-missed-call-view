//
//  CallView.swift
//  Youtube_CallsUI
//
//  Created by Sopheamen VAN on 17/7/24.
//

import SwiftUI

struct CallView: View {
    // set detault picker state
    @State private var selectionCall: String = "All"
    var body: some View {
        NavigationStack {
            ScrollView {
                // content here
                VStack (spacing: 16){
                    // call header view
                    CallHeaderView()
                    
                    // switch content All or Missed
                    switch selectionCall {
                    case "All" :
                        CallRecentView()
                    case "Missed":
                        MissedCallView()
                    default:
                        EmptyView()
                    }
                    
                }
            }
            .toolbar {
                // leading item
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Text("Edit")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primaryColor)
                    }
                }
                // trailing item
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "phone")
                    }
                }
                // center items
                ToolbarItem (placement: .principal){
                    // picker segments
                    Picker("",selection: $selectionCall) {
                        // layout here
                        Text("All").tag("All")
                        Text("Missed").tag("Missed")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 40)
                    
                    
                }
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CallView()
}

struct CallHeaderView: View {
    var body: some View {
        VStack (spacing: 6){
            Text("Calls")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // card content
            HStack (spacing: 12){
                Image(systemName: "link")
                    .resizable()
                    .scaledToFill()
                    .fontWeight(.semibold)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.primaryColor)
                    .padding(.all, 12)
                    .background(Color.backgroundColor)
                    .clipShape(Circle())
                //
                VStack (alignment: .leading, spacing: -2){
                    Text("Create Call Link")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.primaryColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Share a link for your WhatsApp call")
                        .font(.footnote)
                        .foregroundStyle(Color.blackOpacity)
                }
            }
            .padding(.all, 12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
    }
}

struct CallRecentView:View {
    //
    var callAllDatas: [CallResponse] = callData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Recent")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            // fetch all call recents from dummy data
            LazyVStack (spacing: 0){
                ForEach(callAllDatas) { callRecent in
                    CallProfileViewRow(callRespone: callRecent)
                }
            }
            .padding(.top, 10)
            .padding(.bottom , -10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .padding(.horizontal)
    }
}

struct CallProfileViewRow:View {
    var callRespone: CallResponse
    var body: some View {
        VStack (spacing: 8){
            // content here
            HStack (spacing: 10){
                ProfileImageView(profileImage: currentUserData.profileUrl, size: 45)
                VStack (alignment: .leading, spacing: -3){
                    Text(callRespone.user.name)
                        .font(.headline)
                        .fontWeight(.regular)
                        // check call type as word or digit and putting the color
                        .foregroundStyle(callRespone.type == 1 ? Color.dangerColor : .black)
                    HStack (spacing: callRespone.callType == 1 ? 6 : 10){
                        Image(systemName: callRespone.callType == 1 ? "phone.fill" : "video.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: callRespone.callType == 1 ? 14 : 12, height: callRespone.callType == 1 ? 14: 12)
                            .foregroundStyle(.gray.opacity(0.8))
                        
                        // switch call type
                        switch callRespone.type {
                        case 1:
                            Text("Missed")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        case 2:
                            Text("Incoming")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        case 3:
                            Text("Outgoing")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        default:
                            Text("Not Found")
                        }
                        
                    }
                   
                    
                }
                Spacer()
                HStack (spacing: 10){
                    Text(callRespone.time)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.primaryColor)
                }
            }
            Divider()
                .padding(.leading, 55)
        }
        .padding(.bottom , 8)
        .padding(.horizontal, 12)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(.white)
        
    }
}

struct MissedCallView:View {
    //
    var callAllDatas: [CallResponse] = callData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Missed Call")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            // fetch all call recents from dummy data
            LazyVStack (spacing: 0){
                ForEach(callAllDatas) { missedCall in
                    if missedCall.type == 1 {
                        CallProfileViewRow(callRespone: missedCall)
                    }
                    
                }
            }
            .padding(.top, 10)
            .padding(.bottom , -10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // setting info
            HStack (spacing: 8){
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.gray)
                Text("Your personal calls are")
                    .font(.footnote)
                    .foregroundStyle(.gray) +
                Text(" end-to-end encrypted")
                    .font(.footnote)
                    .foregroundStyle(Color.primaryColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            
        }
        .padding(.horizontal)
    }
}
