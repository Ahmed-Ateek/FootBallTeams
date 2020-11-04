import Foundation
import Alamofire

class RequestManager {
    // single tone :D
    static let sharesInstance = RequestManager()
    // this func only for sending data and reciving
    func request<T: Codable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?, andHeaders headers: [String: String]?, completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)",parameters as Any)
        Alamofire.request(url, method: method, parameters: parameters,encoding:JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let code  = response.response?.statusCode ?? -1
            let result = response.result
            print( "API is Returning for \(url) : - " ,result.value ?? [:]) //by-Ahsan
            let error = "Oops Error Please Try Again"
            switch result {
            case .success( _):
                if code == 200 || code == 201 || code == 203 {
                    self.handleSuccess(response: response, completion: completion, code: code)
                }else {
                    self.handleError(response: response, completion: completion, code: code, error: error)
                }
                break
            case .failure(let error):
                completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
    func requestWithArray<T: Codable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [[String:Any]]?, andHeaders headers: [String: String]?, completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)")
        
        let urlString = url
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "" , forHTTPHeaderField:"token")
        do {
            
            request.httpBody   =  try JSONSerialization.data(withJSONObject: parameters!)
        } catch let error {
            print(error)
        }
        
        
        Alamofire.request(request).responseJSON { (response) in
            
            let code  = response.response?.statusCode ?? -1
            let result = response.result
            print(result)
            let error = "Oops Error Please Try Again"
            switch result {
            case .success( _):
                if code == 200 || code == 201 || code == 203 {
                    self.handleSuccess(response: response, completion: completion, code: code)
                }else {
                    self.handleError(response: response, completion: completion, code: code, error: error)
                }
                break
            case .failure(let error):
                completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
    
    func requestInBody<T: Codable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any], andHeaders headers: [String: String], completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)")
        
        let urlString = url
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "" , forHTTPHeaderField:"token")
        
        do {
            request.httpBody   =  try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error)
        }
        print(request.httpBody?.count)
        
        Alamofire.request(request).responseJSON { (response) in
            
            let code  = response.response?.statusCode ?? -1
            let result = response.result
            print(result)
            let error = "Oops Error Please Try Again"
            switch result {
            case .success( _):
                if code == 200 || code == 201 || code == 203 {
                    self.handleSuccess(response: response, completion: completion, code: code)
                }else {
                    self.handleError(response: response, completion: completion, code: code, error: error)
                }
                break
            case .failure(let error):
                completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
    
    
    
    // with image
    func requestWithImage<T: Decodable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:String]?, imageData:[Data] , imageKey:String ,andHeaders headers: [String: String]?, completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            let count = imageData.count
            
            for i in 0..<count{
                multipartFormData.append(imageData[i], withName: "morephoto[\(i)]" ,fileName:  "photo\(i).jpg", mimeType: "image/jpg")
            }
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }
        },to:url,method: method,headers: headers){ (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    let code  = response.response?.statusCode ?? -1
                    let result = response.result
                    let error = "Oops Error Please Try Again"
                    switch result {
                    case .success( _):
                        if code == 200 || code == 201 || code == 203 {
                            self.handleSuccess(response: response, completion: completion, code: code)
                        }else {
                            self.handleError(response: response, completion: completion, code: code, error: error)
                        }
                        break
                    case .failure(let error):
                        completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                        break
                    }
                }
            case .failure(let encodingError):
                completion(encodingError.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
    // with video 
    func requestWithVideo<T: Decodable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:String]?, videoData:[Data] , VideoeKey:String ,andHeaders headers: [String: String]?, completion: @escaping CompletionHandler<T>) {
        print("API URL: \(url)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for videoData in videoData {
                multipartFormData.append(videoData, withName: VideoeKey ,fileName: "file.mp4", mimeType: "video/mp4")
            }
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }
        },to:url,method: method,headers: headers){ (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    let code  = response.response?.statusCode ?? -1
                    let result = response.result
                    let error = "Oops Error Please Try Again"
                    switch result {
                    case .success( _):
                        if code == 200 || code == 201 || code == 203 {
                            self.handleSuccess(response: response, completion: completion, code: code)
                        }else {
                            self.handleError(response: response, completion: completion, code: code, error: error)
                        }
                        break
                    case .failure(let error):
                        completion(error.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                        break
                    }
                }
            case .failure(let encodingError):
                completion(encodingError.localizedDescription,ErrorsCodes.requestFailureError.rawValue,nil)
                break
            }
        }
    }
    
    private func handleSuccess<T: Decodable>(response: DataResponse<Any>, completion: @escaping CompletionHandler<T>,code:Int) {
        guard let _data = response.data else {
            completion("\(T.self) unable to cast model",ErrorsCodes.castError.rawValue,nil)
            return
        }
        do{
            let data = try JSONDecoder().decode(T.self, from: _data)
            print(data)
            completion(nil, code ,data)
        } catch {
            completion("error in decoding, please try again later \(error.localizedDescription)",ErrorsCodes.codableError.rawValue,nil)
        }
    }
    
    private func handleError<T: Decodable>(response: DataResponse<Any>, completion: @escaping CompletionHandler<T>,code:Int,error:String) {
        guard let _data = response.data else {
            completion("error occured while handling data, please try again later",ErrorsCodes.castError.rawValue,nil)
            return
        }
        do{
            let data = try JSONDecoder().decode(T.self, from: _data)
            print(data)
            completion(error , code , data)
        } catch{
            completion("error in decoding, please try again later \(error.localizedDescription)",ErrorsCodes.codableError.rawValue,nil)
        }
    }
}
