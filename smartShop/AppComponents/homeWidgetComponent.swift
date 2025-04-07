import SwiftUI
struct homeWidgetComponent: View {
    var foreground : Color
    var image : String
    var text : String
    var smallWidget : Bool
    var body: some View {
        
        if smallWidget {
            VStack (alignment: .center,spacing: 12){
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: 200)
                    .frame(height: 100)
                    .foregroundStyle(foreground)
                    .overlay(
                        VStack(){
                            Text(text)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.foreground)
                            Spacer()
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 40)
                            
                        }
                            .padding(25)
                    )
            }
        }
        else {
            HStack(alignment: .center) {
                RoundedRectangle (cornerRadius: 10)
        
                    .frame(maxWidth: 500)
                    .frame(height: 100)
                    .foregroundStyle(foreground)
                    .overlay(
                        HStack(){
                            Text(text)
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.foreground)
                            Spacer()
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 50)
                            
                        }
                            .padding(30)
                    )
            }
        }
    }
}

#Preview {
    homeWidgetComponent(
        foreground: .blue,
        image: "fill.heart",
        text: "Foods",
        smallWidget: false
    )
}


struct gradient:View {
    var color1: Color
    var color2: Color
    var body: some View {
         LinearGradient(
            colors: [color1, color2],
            startPoint: .bottomLeading,
            endPoint: .bottomTrailing
            )
    }
}
