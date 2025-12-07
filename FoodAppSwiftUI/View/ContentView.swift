//
//  ContentView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

// MARK: - ContentView
/// The main content view displaying food items in either a grid or list layout.
///
/// `ContentView` provides a search bar to filter food items by name and
/// toggles between grid and list display modes. It also includes a header
/// with a profile image and a menu button.
///
/// - Properties:
///   - purchaseCard: Observed object managing the user's cart.
///   - show: Binding to control whether the side menu is visible.
///   - namespace: Namespace for matched geometry animations.
///   - showGridOrList: State to toggle between grid and list views.
///   - searchText: State storing the text input from the search bar.
///
/// Usage:
/// ```swift
/// ContentView(purchaseCard: purchaseCard, show: $show)
/// ```
import SwiftUI

struct ContentView: View {
    /// The cart manager observed for changes and used to add items to the purchase card.
    @ObservedObject var purchaseCard: PurchaseCard
    /// The namespace used for matched geometry animations between list and grid rows.
    @Namespace private var namespace
    /// Controls whether items are displayed in grid (`false`) or list (`true`) layout.
    @State private var showGridOrList: Bool = false
    private let columnsGrid = Array(repeating: GridItem(), count: 2)
    private let columnsList = Array(repeating: GridItem(), count: 1)
    @Binding var show: Bool
    /// Stores the current search text entered by the user.
    @State private var searchText: String = ""
    private let foods = FoodItemData.foodsMock
    /// Filters the foods array based on the current search text.
    /// Returns all items if the search text is empty.
    private var filteredFoods: [FoodItem] {
        guard !searchText.isEmpty else { return foods }
        return foods.filter({ $0.name.localizedStandardContains(searchText)} )
    }
    
    /// The main body of the content view.
    ///
    /// Displays the header, search row, and either a grid or list of food items,
    /// wrapped in a scroll view with spring animation applied when the search text changes.
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                header
                    .topPaddingForDevice()
                searchRow
            }
            .padding(.vertical, 8)
            
            ScrollView(showsIndicators: false) {
                Group {
                    if !showGridOrList {
                        LazyVGrid(columns: columnsGrid, spacing: 12) {
                            ForEach(filteredFoods) { food in
                                GridRowView(purchaseCard: purchaseCard, food: food, namespace: namespace)
                            }
                        }
                    } else {
                        LazyVGrid(columns: columnsList, spacing: 12) {
                            ForEach(filteredFoods) { food in
                                ListRowView(purchaseCard: purchaseCard, food: food, namespace: namespace)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .animation(.spring, value: searchText)
        }
        .background(.bc)
    }
    
    /// The header view containing the menu button, profile image, greeting, and current date.
    var header: some View {
        HStack {
            Button {
                withAnimation { show.toggle() }
            } label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button {

            } label: {
                Image(.imageRec)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .clipShape(.circle)
            }
        }
        .font(.title)
        .padding(.horizontal, 12)
        .overlay(alignment: .center) {
            VStack {
                Text("Hi, Hakob Ghlijyan!")
                    .font(.title3).fontWeight(.semibold)
                Text("\(Date().formatted(date: .complete, time: .shortened)).")
                    .font(.caption).fontWeight(.regular)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    /// The search bar view with magnifying glass icon and text field for filtering items.
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .padding(.leading)
            TextField("Search...", text: $searchText)
        }
        .frame(height: 45)
        .background(.regularMaterial, in: .rect(cornerRadius: 12, style: .continuous))
    }
    
    /// The row containing the search bar and a toggle button to switch between grid and list layouts.
    var searchRow: some View {
        HStack {
            searchBar
            Button {
                withAnimation { showGridOrList.toggle() }
            } label: {
                Image(systemName: showGridOrList ? "rectangle.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
            }
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    ContentView(purchaseCard: PurchaseCard(), show: .constant(false))
}
