//
//  ContentView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var purchaseCard: PurchaseCard
    @Namespace private var namespace
    @State private var showGridOrList: Bool = false
    private let columnsGrid = Array(repeating: GridItem(), count: 2)
    private let columnsList = Array(repeating: GridItem(), count: 1)
    
    @State private var searchText: String = ""
    private let foods = FoodItemData.foodsMock
    private var filteredFoods: [FoodItem] {
        guard !searchText.isEmpty else { return foods }
        return foods.filter({ $0.name.localizedStandardContains(searchText)} )
    }

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                header
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
    }
    
    var header: some View {
        HStack {
            Button {
            
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
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .padding(.leading)
            TextField("Search...", text: $searchText)
        }
        .frame(height: 45)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12, style: .continuous))
    }
    
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
    ContentView(purchaseCard: PurchaseCard())
}
