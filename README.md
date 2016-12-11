##アプリインストール、ビルド、テスト方法

#1 - インストール、ビルド
Download & install the latest version of Xcode from the App Store

Clone this project and its submodules with git clone --recursive

Open XmasDating.xcodeproj and press Command-R to run the app


#２ - テスト方法
  - Couple dating function
  User input email touch button START, if the first time user need take picture or choose a photo from library.
  after that touch button UPLOAD wait to upload image to server and response result from server as age, gender...
  touch START then see list suggestion users from server.
  touch on user if you like -> touch INVITE to request dating. if selected user accept you
  dating has started.
  
  - group dating
  touch GROUP to show all user in area. touch on some users you like then sent invite request.
  all people accept then start dating.
  
  - dating
  when dating has started it will show dating's location, member's location on the map.
  show notify when member near destination.
  
  - find location and channel register
  input location to search, or choose channel that you want.
  show location or channel on map.
  if user near the others at the same channel then can chat although have no internet. 
  
  
##オープンソースライブラリ一覧


#1 face api
+ face detect api
+ face familiar api
https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236


#2 View map
+ https://github.com/googlemaps/OpenInGoogleMaps-iOS



#3 Chatting no internet in channel
+ https://www.appcoda.com/chat-app-swift-tutorial/
+ https://developer.apple.com/reference/multipeerconnectivity


##アーキテクチャー図
https://esa-pages.io/p/sharing/5032/posts/6/d2223d9352464a1736c7.html

## Presentation

Noel_Dating_Presentation.pdf

