# ⚾ 숫자 야구 게임

- 숫자 야구 게임은 컴퓨터가 생성한 중복 없는 숫자를 맞히는 콘솔 기반 게임  
- 사용자는 숫자를 입력하고 **스트라이크 / 볼 / 아웃** 결과를 통해 정답을 추론함
- 게임 시도 횟수를 보여주는 기능이 존재

# 🎬 실행화면
![baseballgame](https://github.com/user-attachments/assets/c4027adf-c2b2-436e-961f-793165b99749)

# 📊 클래스 다이어그램
<img width="5056" height="5792" alt="image" src="https://github.com/user-attachments/assets/d8946478-3cb5-44c7-9d57-7111fd25cd42" />

# 🗂️ 파일 트리

```swift
├── README.md
└── YSBaseballGame
    ├── YSBaseballGame
    │   ├── BaseballGame.swift
    │   ├── GameController.swift
    │   ├── GameHistory.swift
    │   ├── main.swift
    │   ├── Model
    │   │   ├── GameRule.swift
    │   │   ├── Judge.swift
    │   │   ├── MenuChoice.swift
    │   │   └── UserInstruction.swift
    │   └── Protocol
    │       ├── inputting.swift
    │       ├── Judging.swift
    │       └── NumberGenerating.swift
    └── YSBaseballGame.xcodeproj
```

# 🧐 고민 했던 점 
- 객체지향설계를 신경써서 해보았습니다.

## 1️⃣ 타입 정하기
`main`에 함수만 주르륵 있던 코드를 분리하면서 각자 어울리는 객체 타입을 선택해주려고 했다. 나름 고민해가면서 고르는 기준을 세웠다. 

- 1) 단순히 값들이 모여있는가 혹은 계산/로직인가? - `struct`
- 2) 역할이나 행동이 주된 것인가? - `protocol`
- 3) 정체성이 강하고 상태가 있거나 공유해야 하는가? - `class`

### 💡 struct
예를 들어 야구게임에서는

- `Judgement`: 판정 결과의 답을 가짐
- `GameRule`: 게임 규칙들의 값들
- `Digit`: 야구게임이 진행되는 자릿수(사용자가 맞춰야하는 숫자 수)
- `BaseballGame`: 단판을 판정해주는 기능

이것들은 `struct`가 적절한 거 같다. 단순한 계산이나 값들이고 규칙과 결과는 공유될 필요는 없고 오히려 공유되면 위험할 수 있다고 생각했다.

### 💡 protocol
어떤 기능만 하거나 로직만 있다면 `protocol`이 적절한 거 같다.
야구게임 내에서 아래의 두 `protocol`은 원래 `struct`으로 만들었던 것을 변경한 것이다. `struct`라고 하기에는 단순히 값 보단 역할이나 행동이라고 보였다.

- `Judging`: 게임의 승패를 판단하는 역할
- `NumberGenerating`: 게임에 쓰일 숫자들을 만드는 행동
- `Inputting`: 사용자 입력을 가져오는 기능

`Inputting`의 경우 이런 식으로 `protocol`로 만든다면 `test`하기도 용이해지는 이점이 있다.

### 💡 class
`class`는 정체성과 상태를 가진 객체라고 생각해서 그것을 바탕으로 결정해 보았다.

- `GameController`: 게임을 진행하거나 종료하고 내부 상태를 저장
- `GameHistory`: 사용자가 몇 회차에 얼마나 시도를 했는지 저장, 종료 될 시 리셋

`GameHistory`는 사용자가 얼마나 몇회 차에 얼마나 시도를 했는지 저장해주는 객체이다. 처음에는 값이니까 `struct`가 아닐까 했는데 누적되는 값이고 그게 상태에 가깝다고 생각해서 `class`로 해주었다.
`GameController`는 하나가 존재하면서 흐름을 책임지는 면이 `class`에 적절하다고 생각했다.

## 2️⃣ GameRule을 어떻게 제한할 것인가

게임룰은 충족시켜야 하는 조건 몇 가지가 있었다. 이를 따르기 위해 코드에 몇 가지를 적용해 보았다.
- `GameRule`은 게임 전체에서 공통으로 사용되는 ‘변하지 않는 규칙'이다.
- 외부에서 한번 정해지고 내부에서는 절대 수정되어서는 안된다.

### 의존성 주입
```swift
init(rule: GameRule) {
    self.rule = rule
}
```
- `GameController`는 GameRule을 스스로 만들지 않고 외부에서 이미 결정된 것을 쓰도록 만듦

### let 으로 선언
```swift
let rule: GameRule
```
- 객체가 살아있는 동안에는 규칙은 바뀌지 않는다.


