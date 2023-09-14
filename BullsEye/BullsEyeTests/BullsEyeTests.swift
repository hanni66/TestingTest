/// Copyright (c) 2023 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import BullsEye

// 모델을 테스트하고 테스트 실패를 디버그하는 방법
final class BullsEyeTests: XCTestCase {
  var sut: BullsEyeGame!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = BullsEyeGame()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testScoreIsComputedWhenGuessIsHigherThanTarget() throws {
    // given (주어진) : 여기에서 필요한 값을 설정합니다. 이 예에서는 guess 값을 생성하여 targetValue와 차이가 얼마나 나는지 지정할 수 있습니다.
    let guess = sut.targetValue - 5

    // when (언제) : 이 섹션에서는 테스트 중인 코드를 실행합니다. check(guess:)를 호출합니다.
    sut.check(guess: guess)

    // then (그 다음) : 테스트가 실패하면 인쇄되는 메시지와 함께 예상한 결과를 주장하는 섹션입니다. 이 경우 sut.scoreRound는 100 - 5이므로 95와 같아야 합니다.
    XCTAssertEqual(sut.scoreRound, 95, "guess로 계산된 점수가 잘못되었습니다.")
  }
  
  // 성능 테스트
  func testScoreIsComputedPerformance() {
    measure(
      metrics: [
        XCTClockMetric(), // 경과 시간을 측정
        XCTCPUMetric(),   // CPU 시간, 주기 및 명령어 수를 포함한 CPU 활동을 추적
        XCTStorageMetric(), // 테스트된 코드가 스토리지에 쓰는 데이터의 양을 알려줌
        XCTMemoryMetric() // 사용된 실제 메모리의 양을 추적
      ]
    ) {
      sut.check(guess: 100)
    }
  }
  
}
