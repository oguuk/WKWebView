//
//  KakaoAuthService.swift
//  Social_Login
//
//  Created by oguuk on 2023/10/11.
//

import UIKit

enum Constant {
    static let redirectURI = "oguuk.github.io"
    static let authBaseURL = "https://kauth.kakao.com"
    static let apiBaseURL = "https://kapi.kakao.com"
    static let tokenPath = authBaseURL + "/oauth/token"
    static let authorizePath = authBaseURL + "/oauth/authorize"
    static let imageProfilePath = apiBaseURL + "/v1/api/talk/profile"
    static let userInfoPath = apiBaseURL + "/v2/user/me"
}

// MARK: - AuthService
protocol AuthService {
    func requestAccessToken(with code: String, clientID: String, redirectURI: String, completion: @escaping ([String: String?]?) -> Void)
    func fetchImage(accessToken: String, completion: @escaping (String, UIImage?) -> Void)
}
final class KakaoAuthService: AuthService {
    
    func requestAccessToken(with code: String,
                            clientID: String,
                            redirectURI: String,
                            completion: @escaping ([String: String?]?) -> Void) {
        let url = URL(string: Constant.tokenPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "grant_type=authorization_code&client_id=\(clientID)&redirect_uri=https://\(redirectURI)&code=\(code)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let accessToken = json["access_token"] as? String
                        let refreshToken = json["refresh_token"] as? String
                        completion(["accessToken" : accessToken, "refreshToken" : refreshToken])
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
    }
