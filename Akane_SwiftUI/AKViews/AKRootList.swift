//
//  AKRootList.swift
//  Akane
//
//  Created by 御前崎悠羽 on 2021/7/13.
//  Copyright © 2021 御前崎悠羽. All rights reserved.
//

import SwiftUI

struct AKRootList: View {
    @EnvironmentObject var modelData: AKModelData
    
    struct RootList: Identifiable {
        var id: String
        var imageName: String
        var name: String
    }
    
    var sortList: [Self.RootList] = [
        Self.RootList(id: "All", imageName: "film", name: "全部"),
        Self.RootList(id: "iCloud", imageName: "icloud", name: "iCloud")
    ]
    var linkList: [Self.RootList] = [
        Self.RootList(id: "Files", imageName: "folder", name: "文件"),
        Self.RootList(id: "Link", imageName: "link", name: "连接")
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("资料库")) {
                    ForEach(self.sortList) { sort in
                        NavigationLink(
                            destination: AKDetailView(),
                            label: {
                                AKScanRow(name: sort.name, imageName: sort.imageName)
                                    .frame(height: 50)
                                    .listRowBackground(Color(.red))
                                    //.listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                            })
                    }
                }
                Section(header: Text("连接")) {
                    ForEach(self.linkList) { link in
                        NavigationLink(
                            destination: AKDetailView(),
                            label: {
                                AKScanRow(name: link.name, imageName: link.imageName)
                                    .frame(height: 50)
                                    //.listRowBackground(Color(.systemGroupedBackground))
                                    //.listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                            })
                    }
                }
                Section(header: Text("播放列表")) {
                    ForEach(self.modelData.playlists) { playlist in
                        NavigationLink(
                            destination: AKDetailView(),
                            label: {
                                AKScanRow(name: playlist.name, iconURL: playlist.iconURL!)
                                    .frame(height: 50)
                                    //.listRowBackground(Color(.systemGroupedBackground))
                                    //.listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                            })
                    }
                }
            }
            .frame(minWidth: 300)
            .listStyle(SidebarListStyle())
            .navigationTitle("浏览")
            
            Text("选择一个列表来显示。")
        }
    }
}

struct AKRootListView_Previews: PreviewProvider {
    static let deviceName: String = "iPhone 12"
    
    static var previews: some View {
        #if iOS
        AKRootList()
            .environmentObject(AKModelData())
            .previewDevice(PreviewDevice.init(rawValue: deviceName))
            .previewDisplayName(deviceName)
        #elseif macOS
        AKRootList()
            .environmentObject(AKModelData())
        #endif
    }
}
