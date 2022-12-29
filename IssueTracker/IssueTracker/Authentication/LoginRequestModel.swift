//
//  LoginRequestModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/28.
//

import Foundation

class LoginRequestModel {
  
  private let requestModel = HTTPRequestModel(URL.apiURL)
  private let responseModel = HTTPResponseModel()
  
  let dataProcessingError = LoginRequestError.processFailed("데이터 처리 도중 오류가 발생하였습니다. 다시 시도해주시기 바랍니다.")
  let unRecognizedResopnseError = LoginRequestError.unRecognizedResponse
  let accessTokenError = LoginRequestError.errorWithCode(1001)
  let refreshTokenError = LoginRequestError.errorWithCode(1004)
  
  /// Check data with response has error-code or error-message. If it isn't, returns nil.
  private func getErrorResponseData(_ data: Data) -> LoginRequestError? {
    if let errorCode = self.responseModel.getErrorCodeResponse(from: data) {
      return LoginRequestError.errorWithCode(errorCode)
    } else if let message = self.responseModel.getMessageResponse(from: data) {
      return LoginRequestError.errorWithMessage(message)
    }
    
    return nil
  }
  
  /// Get result instance from response. If fails, result instance contains RequestError.
  private func getResultFromData<T: Decodable>(_ data: Data) -> Result<T, LoginRequestError> {
    guard let resultData = self.responseModel.getDecoded(from: data, as: T.self) else {
      return .failure(self.getErrorResponseData(data) ?? .unExpectedData)
    }
    
    return .success(resultData)
  }
  
  func requestLogin(_ id: String,
                    _ password: String,
                    completionHandler:
                    @escaping (Result<LoginResponse, LoginRequestError>)->Void
  ) {
    
    guard let model = requestModel else { return }
    
    model.builder.setBody(["id": id, "password": password])
    model.builder.setHTTPMethod("POST")
    model.request(pathArray: ["members", "signin"]) { result, response in
      
      guard let response = response as? HTTPURLResponse else {
        
        completionHandler(.failure(
          self.unRecognizedResopnseError
        ))
        
        return
      }
      
      switch response.statusCode {
      case 401:
        do {
          let data = try result.get()
          let error = self.getErrorResponseData(data) ?? self.accessTokenError
          
          completionHandler(.failure(error))
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        }
        
      case 200..<300:
        do {
          
          completionHandler(
            self.getResultFromData(
              try result.get()
            )
          )
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        } // end of do-catch
        
      default:
        
        completionHandler(.failure(
          LoginRequestError.failedRequest
        ))
      } // end of switch
    } // end of request
  }
  
  func checkAlreadyLogin(completionHandler:
                         @escaping (Result<Int, LoginRequestError>)->Void
  ) {
    
    guard let model = requestModel else { return }
    
    model.request(pathArray: ["auth", "test"]) { result, response in
      
      guard let response = response as? HTTPURLResponse else {
        
        completionHandler(.failure(
          self.unRecognizedResopnseError
        ))
        
        return
      }
      
      switch response.statusCode {
      case 401:
        
        do {
          let data = try result.get()
          let error = self.getErrorResponseData(data) ?? self.accessTokenError
          
          completionHandler(.failure(error))
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        }
        
      case 200..<300:
        do {
          
          completionHandler(
            self.getResultFromData(
              try result.get()
            )
          )
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        } // end of do-catch
        
      default:
        
        completionHandler(.failure(
          LoginRequestError.failedRequest
        ))
      } // end of switch
    } // end of request
  }
  
  /// 사용하지 않음. body 에 대한 부분을 좀 더 명확히 할 필요가 있음.
  func refreshAccessToken(completionHandler:
                          @escaping (Result<LoginResponse, LoginRequestError>)->Void
  ) {
    
    guard let model = requestModel else { return }
    
    model.request(pathArray: ["auth", "reissue"]) { result, response in
      
      guard let response = response as? HTTPURLResponse else {
        
        completionHandler(.failure(
          self.unRecognizedResopnseError
        ))
        return
      }
      
      switch response.statusCode {
      case 401:
        do {
          let data = try result.get()
          let error = self.getErrorResponseData(data) ?? self.accessTokenError
          
          completionHandler(.failure(error))
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        }
        
      case 200..<300:
        do {
          
          completionHandler(
            self.getResultFromData(
              try result.get()
            )
          )
          
        } catch {
          
          completionHandler(.failure(
            self.dataProcessingError
          ))
        } // end of do-catch
        
      default:
        
        completionHandler(.failure(
          LoginRequestError.failedRequest
        ))
      } // end of switch
    } // end of request
  }
}
