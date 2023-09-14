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
// XCTestExpectation을 사용하여 비동기 작업(Asynchronous Operations) 테스트

final class BullsEyeSlowTests: XCTestCase {
  
  var sut: URLSession!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = URLSession(configuration: .default)
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  // Asynchronous test: success fast, failure slow
  // urlString 502 error (2023.09.14)
  func testValidApiCallGetsHTTPStatusCode200() throws {
    let networkMonitor = NetworkMonitor.shared
    
    try XCTSkipUnless(
      networkMonitor.isReachable,
      "Network connectivity needed for this test."
    )
    // given
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    
    // 1 : promise에 저장된 XCTestExpectation을 반환합니다. 설명은 예상되는 상황을 설명합니다.
    let promise = expectation(description: "Status code: 200")
    
    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      // then
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)")
        return
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
        if statusCode == 502 {
          // 2 :  비동기 메서드 완료 핸들러의 성공 조건 클로저에서 이것을 호출하여 expectation이 충족되었음을 플래그로 표시합니다.
          promise.fulfill()
        } else {
          XCTFail("Status code: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    
    // 3 : 모든 expectation이 충족되거나 시간 초과 간격(timeout)이 끝날 때까지 중 먼저 발생하는 시점까지 테스트를 계속 실행합니다
    wait(for: [promise], timeout: 5)
  }
  
  // urlString 502 error (2023.09.14)

  func testApiCallCompletes() throws {
    // given
    let urlString = "http://www.randomnumberapi.com/test"
    let url = URL(string: urlString)!
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?

    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)

    // then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }

}
