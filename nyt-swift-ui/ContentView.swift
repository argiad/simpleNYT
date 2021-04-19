//
//  ContentView.swift
//  nyt-swift-ui
//
//  Created by Artem Mkrtchyan on 4/15/21.
//

import SwiftUI

struct ResultView: View{
    var choice: String
    var body: some View{
        Text("ResultView \(choice)")
    }
}


struct ArticlesListView: View {
    @EnvironmentObject var bl: BusinessLogic
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bl.items, id: \.self) {item in
                    NavigationLink(
                    
                        destination: ResultView(choice: ">> \(item.article.abstract)"))
                    {
                        ArticleView(item: item)
                    }
                }
            }
        }
        
    }
}

struct ContentView: View {
    @State private var isShowingDetail = false
    
    var body: some View {
        ArticlesListView()
        //        NavigationView {
        //
        ////            NavigationLink (
        ////                destination: ResultView(choice: "222"), isActive: $isShowingDetail){}
        ////
        ////            VStack(alignment: .center, spacing: 30) {
        ////                /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        ////
        ////                NavigationLink (
        ////                    destination: ResultView(choice: "1111")){
        ////                    Text("nav")
        ////                }
        ////
        ////                Button("Tap to show nav View"){
        ////                    isShowingDetail = true
        ////                }
        ////            }
        //            List {
        //                ArticleView(item: nil)
        //                ArticleView(item: nil)
        //            }
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
