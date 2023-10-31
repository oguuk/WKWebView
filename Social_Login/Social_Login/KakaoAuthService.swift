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
