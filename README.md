# Pomodoro Timer
## Video Demo  <URL HERE>
## Description
The Pomodoro Method is one of the most efficient ways of learning through dividing work/study sessions into manageable chunks of time. One can use a traditional timer or the default timer app on the phone to practice this method. This app helps facilitates this by providing an intuitive way of managing, with designated tabs for each session: Pomodoro, Short Break and Long Break. Moreover, the app supports Live Activities and Dynamic Island, making the app a more immersive experience. The app is available on iOS 17.2 and later

## Features
* Pomodoro Technique: Utilizes the Pomodoro method, consisting of focused work sessions (Pomodoro), short breaks between each Pomodoro, and a longer break after completing a set number of Pomodoros.
* Customizable Sessions: Users can customize the duration of Pomodoro, short breaks, and long breaks to suit their preferences.
* Visual Progress: Displays a circular progress bar to visualize the remaining time in each session.
* ActivityKit Integration: The timer persists on the lock screen and the Dynamic Island, ensuring users stay on track even when the app is not active.
* Theme Customization: Offers various themes to personalize the app interface.

## Installation
Clone the repository and open the project in Xcode. Build and run the app on your iOS device or simulator.

## Usage
1. Set the duration of the Pomodoro, short breaks, and long breaks in the settings.
2. Tap the play button to start the timer.
3. Focus on your work during the Pomodoro session.
4. Take short breaks between Pomodoros.
5. After completing a set number of Pomodoros, take a longer break.
6. Customize the app theme and settings as desired.

#How the app works

##Launching the app
While creating the app, I always had user experience in mind. So in the code i have implemented plenty of logic and functions that keeps the app easy to use. When the app is first launched, the user is immediately welcomed with an onboarding sheet that explains how to best utilise this app. After clicking Continue, the main screen appears with 3 colorful cards representing 3 different time intervals. The welcome screen will not appear again in after uses unless the user hits the info button on the top right corner.

##Tabs
All of the 3 timers can be easily accessed by swiping or clicking the buttons on the bar at the bottom of the screen. Each timer is presented in the form of card view, each card contains the reset button, the time remaining which is represented through text and a custom circular progress bar, and lastly the start/ stop button. Upon clicking this button, the timer starts counting down, then it’s recommended for the user to turn off the phone and start focusing or taking a break depending on the initiated timer. Clicking the start button also starts the live activity on the user’s lockscreen, notification center and dynamic island, allowing the user to quickly get to know the time remaining at just a glance.  User can also set the timer on Standby mode by placing the phone horizontally while charging.

##Edit View
Users can easily modify the duration and theme of each category by clicking the edit button on the top right of the screen. A detail edit sheet will then appear. The length of each session can be at 1 minute minimum and 60 minutes maximum, which is the recommended maximum time a focus session should take. Changing the theme of a category will change the background color of the card. This change is also reflected through the Tab navigation bar at the bottom of the screen. If the user want to dismiss the change made, just hit cancel. To save the changes, click Done. If a timer is running while the edit sheet is presented, it will only reset when a change is made to its duration.

##Timer
When clicking the start button, the app will terminate all running live activities and reset the other running timer if any, eliminating the user’s need to manually click the stop button each time they want to start a new timer. When timer hits zero, the start/ stop button will act as both the reset and start timer in case the user wants to start that timer again. 


#What's underneath the hood
##PomodoroApp.swift, ErrorWrapper.swift
These files establish the main structure of the Pomodoro timer application, handling its UI, data management, error handling, and lifecycle management.

##TabDetails.swift, TabStore.swift
For storing data, I created a TabDetails struct containing session lengths and themes. I've included a default dataset to set up the app for first-time users. The theme is a custom struct borrowed from Apple's iOS development tutorial course. I also adjusted the ScrumStore function to persist user changes to tab settings.

##ContentView.swift
The app's main menu features three instances of a custom card view called TimerCardView. Each instance receives the tabs binding variable passed down from the PomodoroApp struct, as well as the session appearing on screen, its duration, a timer instance, and a boolean to determine if a new timer has started to reset other running timers.

##CustomTabBar.swift
At the bottom of the screen is a custom tab bar reflecting the theme of each study session.

##DetailEditView.swift
The edit button in the top-right corner enables users to modify the duration and themes of all three tabs simultaneously. Sessions can range from 1 to 60 minutes, the recommended maximum length for a Pomodoro session. The timer resets only when changes are made to the running timer's duration, allowing users to freely modify other settings while the timer continues.

##PomodoroTimer.swift
Before exploring the TimerCardView struct, let's examine the core of the app: the PomodoroTimer class. This class, marked with @MainActor, ensures the timer runs on the main thread. It's an observable object with four @Published variables accessible and modifiable by other views. The class features basic functions for starting, stopping, and resetting the timer, updating secondsElapsed and secondsRemaining.

##TimerCardView.swift
This view utilizes the secondsRemaining and secondsElapsed values to update the progress bar and TimerWidget for live activities. It also includes start, stop, and reset functions that call corresponding functions in the PomodoroTimer class and update live activities. When the timer hits zero, the view checks the timerFired value, calls the stopTimer function, and sets isTrackingTime to false, transitioning the stop button back to the start button. The shouldResetTimer variable from the PomodoroTimer class indicates when to reset the timer, triggered when a new timer starts while another is still running or when the user finishes editing the timer.
To handle background operations, I implemented two onReceive modifiers for know whether the app is inactive. When the user quits the app, the function records the last time the app checked the timer status. Upon returning to the foreground, it calculates the accumulated time and restarts the timer, updating live activities for synchronization.


##TimerAttributes.swift, TimerWidgetBundle.swift, TimerWidget.swift
Supporting live activities and the dynamic island, I've implemented ActivityKit. The ActivityAttributes include endTime, secondsRemaining, session name, and theme. Only two of which are being used in the live activities, i haven’t find a way to pass a color to the TImerWidget since type Color does not conform to Codable protocol. And since i borrowed some Live activities code from the internet, i didn’t modify the endTime variable since it will probably messes the function up.
