//
//  Environment.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Foundation
 
public enum Environment {
    
    // MARK: Type
    case sandbox
    case production
    
    // MARK: Selected Values of Environment
    static var currentEnvironment: Environment = .sandbox
    static var apiVersion: String = "v2.3"
}

extension Environment {
    // MARK: - Values
    static var oauthAPIURL: String {
        switch currentEnvironment {
        case .sandbox:
            return "https://sandbox-gac.sandbox.2c2p.net"
        case .production:
            return "https://gac.2c2p.com"
        }
    }
    
    static var baseURL: String {
        switch currentEnvironment {
        case .sandbox:
            return "https://sandbox-gac.sandbox.2c2p.net"
        case .production:
            return "https://gac.2c2p.com"
        }
    }
    
    static var oauthKey: String {
        switch (currentEnvironment) {
          case .sandbox:
            return "Basic ZWFzeTp1bTh3N0VUa2x6MXhJVVV1cVVlQklh";
          case .production:
            return "Basic ZWFzeUNhcmQ6VUZyZUhtVmZ1V09tdmR6UE9HaFl2Zw==";
        }
    }
    
    static var gacAesKey: String {
        switch (currentEnvironment) {
          case .sandbox:
            return "uo1TS67SSQ4g4qFwkVK6gglVr0wPpVme8FDvOXjnCK8=";
          case .production:
            return "I7E3GPFyqWcq9OtrqIjpmQhIM1eQThxmhFZfZLlf/DU=";
        }
    }
    
    static var gacAesIV: String {
        switch (currentEnvironment) {
          case .sandbox:
            return "Mkq6e2LnKEudXcXn7rxvkw==";
          case .production:
            return "FiQKKJT5jqypFPsHZBXWvA==";
        }
    }
    
    static var gacPGPDecryptPassword: String {
        switch (currentEnvironment) {
          case .sandbox:
            return "P@ssw0rd";
          case .production:
            return "P@ssw0rd";
        }
    }
    
    static var gacPGPEncryptKey: String {
        switch (currentEnvironment) {
          case .sandbox:
            return """
mQENBF4lRaEBCADCCJC1+aZPeLQVrqCoJMBChAHe4LC9vOfVF4qejesMebgp3gRO
53lGJyaOKn5AsxNiy1dI0j6Nlw2Kkoj1bZ1bY/dlAzMTFnFr56c0Z0xO/tBDqTPE
5pOQZM2SgFPSCsvIlfEmVBb+O8isupPvswqi3RF3lOhzbRT45qEB07f6+AOQDTbX
IysqBfNMTTq0YMQB1LwqOPpF3VFbpbTqMyfFTu5BZ+49HTG4WTvn7Z2i4qt4Rhvs
k6MJiL8yjnMHcDhue8fU4R13NXnSfC8bbcrn1ErRqMqr8z2C1aoFtpF+aoyVza8a
uZ9hOHDmiZfoTwx78plWxXuUx0XpFulZfymTABEBAAG0G1VBVC1HQUMgPGl0LWlu
ZnJhQDJjMnAuY29tPokBOQQTAQgAIwUCXiVFoQIbAwcLCQgHAwIBBhUIAgkKCwQW
AgMBAh4BAheAAAoJEBTfcmEWnszlZisH/jwgiZ19mpsKSc50fftvTZf5NnLrTabj
GORTYwb3ZjqrziEID4DycwbSVPigEr1OkVvPOYKgW2LNmya82Kpnvgg3FBAvWW9B
Lh7r9gLOpqLmpMA0MQOb9UZVeDRgNUUgOD+v9aZ/JfMx3LNxh/xjfKVLH8GXlz1U
742pgUG5S1gjldsQjQ/uQkSo1t0v4czrkzJcrndj9Z+OwER15/7006cFoJmcaH7G
c0DYYFqkepjDcSkyndG1jdQxyPfvSRiBRjJ9hV5HgxV43mcGiXGy53/7+AofehM4
g4nCqWMBbJm0sBcVGLMx3wQYstN3my7nlzAGO6bAKinmNmCC/0DqLti5AQ0EXiVF
oQEIAMHbJMeziN6NLs5ynAxAPUX+RyszyjEcmd8q1tnOnUVzL5lV1Kmw+1LSGHSX
MPhT17tHEYPT1Y8g5gLYb5nLi5qjrn1MNtdOsJqMbqdJJVY/PrxTP9B9StV7R97q
VPaURJJAfd3+jvvBA8mrn4qpbuevLWp2yiFrXGP/Xs5OSzqRNl2O5m9R3YmBgSjV
84AaqP7X3wCwCKIhIHn3ivVllrNPGid4BkhxFO0FSkqs0XQWsnrGu6z78yd6e3rA
4LHZHCgPEF+BPPdeQVHeCbrhQhlxKlja/7VfJHzBbusfwExfZ3gNgs0x0484hEd/
8yJsDRqVMyvqb81l1pafKwsFDlEAEQEAAYkBHwQYAQgACQUCXiVFoQIbDAAKCRAU
33JhFp7M5YF5B/4qQhefLlAPybLfK0UFVyWqYL/aUv2VVdkh0G7kCHHUQRgqT9t4
a8sp+AGOJ4t9Eng6uiggwo29nYj70CtPsxGpKpJy8qKmwstCbfVPamHsooKLW56/
IZ5Nw3tE5vw7uOdkRx7sc4eGiF0GMthnKMacjtxy/S1h6ZxGgyelwxBEGRa20Mqx
v7Qi2Q5+m51fqfE+HN1avPj/wK4rbvuI15+GNRPPfJxEfhOeYd7ZgtC2Za7V84ID
4ZqLKGL/MdQutitQ/pAJ0rNcMkxUpf++rqvNBilO9o0ogLj6EFqWF7JQEasIPvbb
HpU5Su1bY77Bcn4otvlxNY4FbxSu1ibCMtHc
=lNWU
""";
          case .production:
            return "";
        }
    }
    
    static var gacPGPDecryptKey: String {
        switch (currentEnvironment) {
          case .sandbox:
            return """
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
""";
          case .production:
            return "";
        }
    }
    
    static let baseURLDomain = formatCertificatePinning(Environment.baseURL)
    static let oauthDomain = formatCertificatePinning(Environment.oauthAPIURL)
    
    private static func formatCertificatePinning(_ value: String) -> String {
        let removedPrefix = value.replacingOccurrences(of: "https://", with: "")
        guard let removedSuffix = removedPrefix.split(separator: "/").first else {
            return ""
        }
        return String(removedSuffix)
    }
}
