//
//  WelcomeScreen.swift
//  Pomodoro
//
//  Created by Thái Khang on 04/02/2024.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
           /** Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.yellow)
                .padding()
                .accessibility(hidden: true)
            **/
            Text(imageName)
                .font(.largeTitle)
                .foregroundColor(.primary)
                .accessibility(addTraits: .isHeader)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}
struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(title: "Pomodoro Method", subTitle: "The Pomodoro method involves three sessions: work (Pomodoro), short breaks between each Pomodoro, and a longer break after four repetitions.", imageName: "🐣")
            InformationDetailView(title: "Study with your phone off", subTitle: "The timer also lives in the Dynamic Island and on your lockscreen.", imageName: "📱")

            InformationDetailView(title: "Remember to take a break", subTitle: "It's recommended to stand up and walk around after each Pomodoro session.", imageName: "🍃")
        }
        .padding(.horizontal)
    }
}
struct TitleView: View {
    var body: some View {
        VStack {
            Image("pomodoroIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, alignment: .center)
                .accessibility(hidden: true)

            Text("Welcome to")
                .customTitleText()

            Text("Pomodoro Timer")
                .customTitleText()
                .foregroundColor(.yellow)
        }
    }
}
struct WelcomeScreen: View {
    @Binding var welcomeScreenShown: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            TitleView()
            
            InformationContainerView()
            
            Spacer(minLength: 30)
            Button(action: {
               welcomeScreenShown = false
            }) {
                Text("Continue")
                    .customButton()
            }
            .padding(.horizontal)
        }
    }
}
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.yellow))
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

#Preview {
    WelcomeScreen(welcomeScreenShown: .constant(true))
}
