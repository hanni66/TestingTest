# Unit Test 연습하기

테스트를 작성하기 전 기본 사항

- 핵심 기능 모델 클래스, 메서드 및 컨트롤러와의 상호 작용
- 가장 일반적인 UI 워크플로(workflow)
- 경계 조건 (Boundary conditions)
- 버그 수정

# Unit Test란?

→ 사용하려는 기능이 개발자의 의도에 맞게 동작하는지 테스트를 하는 작업이다.

## Commit : 모델을 테스트하고 테스트 실패를 디버그하는 방법

`XCTAssert` 함수를 사용하여 `BullsEye` 모델의 핵심 기능을 테스트한다. 

`BullsEyeGame`이 라운드의 점수를 올바르게 계산하고 있을까?

## Commit : XCTestExpectation을 사용하여 비동기 작업(Asynchronous Operations) 테스트

`BullsEyeGame`은 `URLSession`을 사용하여 다음 게임의 대상으로 임의의 숫자를 가져온다.

`URLSession` 메서드는 비동기 방식이다. 즉시 반환되지만 실행이 완료되지는 않는다. 비동기식 메서드를 테스트하려면 `XCTestExpectation`을 사용하여 비동기식 작업이 완료될 때까지 테스트를 기다려야 한다.

비동기 테스트는 일반적으로 느리므로 더 빠른 단위 테스트와 별도로 격리해야 한다.

`BullsEyeSlowTests`라는 새 단위 테스트 대상을 만든다. 새로운 테스트 클래스 `BullsEyeSlowTests`를 열고 기존 `import` 문 바로 아래에 `BullsEye` 앱 모듈을 가져온다.

## Commit : Faking object와 상호 작용

비동기 테스트는 코드가 비동기 API에 대한 올바른 입력을 생성한다는 확신을 준다. 또한 `URLSession`에서 입력을 수신할 때 코드가 올바르게 작동하는지 또는 `UserDefaults` 데이터베이스 또는 iCloud 컨테이너를 올바르게 업데이트하는지 테스트할 수도 있다.

대부분의 앱은 시스템 또는 라이브러리 객체(당신이 제어하지 않는 객체)와 상호 작용한다. 이러한 객체와 상호 작용하는 테스트는 느리고 반복할 수 없으며 두 가지 FIRST 원칙을 위반할 수 있다. 대신 stub에서 입력을 받거나 mock objects를 업데이트하여 상호 작용을 가짜로 만들 수 있다.

코드에 시스템 또는 라이브러리 개체에 대한 종속성이 있는 경우 가짜를 사용한다. 그 역할을 할 가짜 객체를 만들고 이 가짜를 코드에 주입하면 된다.

- Stub에서 가짜 입력
- Mock object로 가짜 업데이트 **(Commit : Mock object와 상호 작용)**

## Commit : Xcode에서 UI테스트

UI 테스트를 통해 사용자 인터페이스와의 상호 작용을 테스트할 수 있다. UI 테스트는 쿼리로 앱의 UI 개체를 찾고 이벤트를 합성한 다음 해당 개체에 이벤트를 보내는 방식으로 작동한다. API를 사용하면 UI 개체의 속성 및 상태를 검사하여 예상 상태와 비교할 수 있다.

## Commit : 성능 테스트

- **[Apple 문서](https://developer.apple.com/library/prerelease/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/04-writing_tests.html#//apple_ref/doc/uid/TP40014132-CH4-SW8)**

성능 테스트는 평가하려는 코드 블록을 가져와서 10번 실행하여 실행에 대한 평균 실행 시간과 표준 편차를 수집한다. 이러한 개별 측정값의 평균은 테스트 실행에 대한 값을 형성한 다음 기준선(baseline)과 비교하여 성공 또는 실패를 평가할 수 있다.

# Code Coverage

→ Code Coverage는 소프트웨어 개발 과정에서 중요한 메트릭으로, 소스 코드 중에서 테스트 스위트(테스트 케이스)를 실행하여 얼마나 많은 코드가 실행되었는지를 측정하는 지표이다. 

일반적으로 백분율로 표시되며, 100% Code Coverage는 테스트가 모든 코드 경로를 통과했음을 의미한다.

### 참고
- [iOS Unit Testing and UI Testing Tutorial](https://www.kodeco.com/21020457-ios-unit-testing-and-ui-testing-tutorial)
