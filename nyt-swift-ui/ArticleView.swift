//
//  ArticleView.swift
//  nyt-swift-ui
//
//  Created by Artem Mkrtchyan on 4/15/21.
//

import SwiftUI

struct ArticleView: View {
    
    var item: Item?
    
    var body: some View {
        HStack{
            AsyncImage(url: item?.imageURL as URL?,
                       placeholder: { Image("nyt_placeholder") },
                       image: { Image(uiImage: $0) })
                .frame(idealWidth: 120, idealHeight: 80)
                
            
            Text("Article name")
            
            Spacer()
            
        }.frame(height: 80)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(item: nil)
    }
}
