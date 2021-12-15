//
//  ViewController.swift
//  SignWithInAppleTest
//
//  Created by 강대민 on 2021/12/15.
//

import UIKit
//Apple이 제공하는 로그인관련 모든 프레임워크
import AuthenticationServices

class ViewController: UIViewController {

    private let signInButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        // Do any additional setup after loading the view.
        //버튼의 타겟은 뷰 자기자신이며, didtapsignin의 함수를 받아온다, 그리고 터치됐을떄 인식된다.
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //그냥 버튼 사이즈
        signInButton.frame = CGRect(x:0, y:0, width: 250, height: 50)
        signInButton.center = view.center
    }
    
    @objc func didTapSignIn() {
        //공급자를 만들어야 한다. 첫번쨰는 apple ID의 승인자.
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
       
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
}

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            let firstName = credential.fullName?.givenName
            let lastName = credential.fullName?.familyName
            let email = credential.email
            
            break
            
        default:
            break
            
        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}







