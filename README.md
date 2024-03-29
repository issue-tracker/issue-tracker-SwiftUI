# issue-tracker-SwiftUI

<img src="https://user-images.githubusercontent.com/29879110/188896648-bceb2ec8-8f58-4648-b360-1e1d614d2ca9.png" style="width: 50%; height=50%" alt="logo-issue-tracker"/>

이슈트래커 iOS 버전 클라이언트 프로젝트 입니다.

UIKit 으로 개발된 프로젝트는 [링크](https://github.com/issue-tracker/issue-tracker-iOS) 를 방문해주시기 바랍니다.

🏃‍♂️**2주 공부 1주 개발 프로젝트 완료!!**

## 📝 Introduce Our Project

> 프로젝트의 이슈 생성 및 관리를 쉽게 도와주는 어플리케이션입니다.<br/>
> 사용자 경험을 중시하여 여러 기술적인 도전을 수행하고 있습니다.

짧은 시간에 성장에 대한 모멘텀을 얻는 것을 가장 중시한 프로젝트입니다.

CS, RxSwift 심화, Combine 등 공부 및 실습으로 인하여 진행된지 오래되었지만 머지않아 다시 진행할 프로젝트입니다. 

---

## 👨‍👩‍👧‍👦 Introduce Our Team

|                                          BE                                           |                                           BE                                           |                                          iOS                                          |                                           FE                                           |                                           FE                                            |
|:-------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------:|
| <img src="https://avatars.githubusercontent.com/u/68011320?v=4" width=400px alt="후"/> | <img src="https://avatars.githubusercontent.com/u/29879110?v=4" width=400px alt="아더"/> | <img src="https://avatars.githubusercontent.com/u/65931336?v=4" width=400px alt="벡"/> | <img src="https://avatars.githubusercontent.com/u/85747667?v=4" width=400px alt="도비"/> | <img src="https://avatars.githubusercontent.com/u/92701121?v=4" width=400px alt="도토리"/> |
|                           [Hoo](https://github.com/who-hoo)                           |                           [Ader](https://github.com/ak2j38)                            |                        [Beck](https://github.com/SangHwi-Back)                        |                        [Dobby](https://github.com/JiminKim-dev)                        |                          [Dotori](https://github.com/mogooee)                           |

## 💻 Tech Stack

<img src="https://img.shields.io/badge/-Swift-red"/> <img src="https://img.shields.io/badge/-SwiftUI-red"> <img src="https://img.shields.io/badge/Test-XCTest-brightgreen"> <img src="https://img.shields.io/badge/Test-TestFlight-blue"> <img src="https://img.shields.io/badge/Persistent-CoreData-blue">

## 📔 Notion Page

* Team Page : https://sphenoid-fight-243.notion.site/1f7abecd77004e76b4adefff2db3624a
* 개인 Page : https://sphenoid-fight-243.notion.site/iOS-Developer-954a5e0816514be3a3049e8d881bdfdd

## 🛠 App Structure & Environment State

👨‍🔧 작업중 ⚙️

```none
┌ App Instance ────────────────────────────────────────────────────────────────────────────┐
|                          ┌────────────────────────┐                                      |
|                          │   @EnvironmentObject   |                                      |
|                          |        UserState       |                                      |
|                          └────────────────────────┘                                      |
|                            ┌──────────────────┐                                          |
|                            |   Login status   |                                          |
|                     ┌──────▼───────┐   ┌──────▼───────┐  ┌────────────────────────────┐  |
|                     |  LoginView   │   |  LoginView   │  | Issue, Label, MileStone... |  |
|                     └──────▲───────┘   └──────────────┘  └────────────────────────────┘  |
|                            |                             ┌──────────┐                    |
| ┌──────────────┐    ┌──────┴───────┐                     │  MyPage  │                    |
| │  OAuthLogin  ├────▶  SignInView  │                     └──────────┘                    |
| └──────────────┘    └──────────────┘                     ┌───────────┐                   |
|                                                          │  Setting  │                   |
|                                                          └───────────┘                   |
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

## ✍️ Coding Convention

> 아래의 모든 사항들은 **권장** 사항임을 유념해주시기 바랍니다. **가독성** 을 위해서라면 아래 사항을 무시해도 괜찮습니다.

* 컨텐츠를 최초 정의하는 View 구조체는 한눈에 뷰의 구조를 파악할 수 있도록 간단/명확하게 해야 한다(코드 가독성 증가).

```swift
struct ContentView: View {
  @State var text: String
  
  var body: some View {
    VStack {
      ChildHStackWithCircle($text)
    }
  }
  
  /// ContentView 의 body 에 정의해도 된다. 하지만 ContentView 의 body 는 뷰의 구조만 설명한다.
  /// 이름으로 어떤 Element 인지 설명하려다 보니 이름이 길어질 수 있다.  
  struct ChildHStackWithCircle: View {
    @State var isEmpty: Bool
    
    @Binding var text: String
    
    init(_ text: Binding<String>, _ status: Binding<String>) {
      self._text = text
      self._status = status
    }
    
    var body: some View {
      HStack(alignment: .center) {
        Circle()
          .foregroundColor(isEmpty ? .red : .blue)
          .frame(width: 8, height: 8)
        TextField("placeHolder", text: $text)
          .onChange(of: text) { newValue in 
            self.isEmpty = newValue.isEmpty
          }
      }
    }
  }
}
```

* 모든 Device (모바일 포함) 에서의 가독성을 위해 한 Line 에 너무 긴 코드를 넣지는 않는다. 파라미터가 두 개 이상인 호출, 선언문은 줄바꿈을 이용한다거나 코드 자체를 다시 한번 확인하는 등의 노력을 기울이도록 한다.

```swift
/// Not Recommended
private var customFont: UIFont {
  isBold ? UIFont.boldSystemFont(ofSize: 15) : UIFont.preferredFont(forTextStyle: .footnote)
}
/// Recommended
private var customFont: UIFont {
  isBold
  ? UIFont.boldSystemFont(ofSize: 15)
  : UIFont.preferredFont(forTextStyle: .footnote)
}
```

* ViewModel 은 View 의 상태값들을 관리합니다. 관리되는 상태값은 ViewModel 에서 업데이트 되거나 @Binding 을 통해 업데이트 되어야 합니다.
  * 이는 상태값이 오작동할 경우 View 에 모든 로직이 포함되어 있다면 유지보수성이 떨어지고, 기능을 수정해야 할 경우 고려해야 할 것들이 많아진다는 판단에 의거함.

```swift
class ViewModel {
  @Published
  var text: String = "" {
    willSet { newValue in
      self.validation(newValue)
    }
  }
  
  private func validation(_ newValue: String) {
    if newValue.count >= 10 {
      // 상태값이 ViewModel 에 의해 업데이트 됩니다.
      text = newValue 
    }
  }
}

struct ContentView: View {
  let vm = ViewModel()
  
  var body: some View {
    VStack {
      // 상태값이 @Binding 을 통해 업데이트 됩니다.
      TextField(text: $vm.text) 
    }
  }
}
```

## 🤔 느낀점

* 처음부터 다국어 버전을 고려하며 시작하였더니 적은 노력으로도 다국어 앱을 만들 수 있었습니다.
* SwiftUI 는 상태관리를 통해 뷰를 재사용 하는 방식으로 개발하는 것이 효율적이라고 생각합니다.
  - Model 은 상태값만을 관리하고 View 는 바인딩 객체를 전달받아 반영할 뿐입니다.
  - Model 은 @State, View 는 @Binding 만 가집니다.
  - Model 은 Unit-Test 를 통해 검증합니다.
  - UIKit 이 UI-Test Target 으로 설정되는 것처럼 View, Style, Shape 등도 UI-Test Target 입니다.

## ❗️ Challenge

* SwiftUI 를 통해 Declarative UI 에 대해 더 깊은 탐구를 할 수 있을 것이라고 생각합니다.
* Commit 주기를 짧고 간결하게 할 수 있도록 연습
  - 커밋 주기가 짧으면 커밋을 수정해야 할 경우 작업이 더 간단해질 것으로 예상.
  - 하지만 필요한 작업이라고 판단된다면 유연성을 발휘할 필요가 있음 
