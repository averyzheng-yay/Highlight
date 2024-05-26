//
//  ContentView.swift
//  Highlight
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoJournalViewModel()
    @State private var showingAddEntry = false
    
    init() {
        // Create a new UITabBarAppearance object
        let appearance = UITabBarAppearance()
        
        // Configure the appearance object with an opaque background
        appearance.configureWithOpaqueBackground()
        
        // Set the background color of the tab bar to black
        appearance.backgroundColor = UIColor.darkGray
        
        // Set the color of the selected tab item to blue
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]

        // Set the color of the unselected tab items to white
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply the configured appearance to the standard appearance of UITabBar
        UITabBar.appearance().standardAppearance = appearance
        
        // If the iOS version is 15.0 or newer
        if #available(iOS 15.0, *) {
            // Also apply the configured appearance to the scroll edge appearance of UITabBar
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        NavigationView {
            TabView {
                JournalListView(viewModel: viewModel, showingAddEntry: $showingAddEntry)
                    .tabItem{Label("Journal", systemImage: "book")}
                ExportCollageView(viewModel: viewModel)
                    .tabItem{Label("Collage", systemImage: "photo.on.rectangle")}
            }
        }
    }
}

extension View {
    func customFont(_ weight: Font.Weight, _ size: CGFloat) -> some View {
        self.font(.system(size: size, weight: weight))
    }
}

extension View {
    func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
