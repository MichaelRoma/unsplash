//
//  Configuration.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

struct Configuration {

    struct UnsplashSettings {
        static let host         = "unsplash.com"
        static let clientID     = Secrets.clientID
        static let clientSecret = Secrets.clientSecret
        static let authorizeURL = "https://unsplash.com/oauth/authorize"
        static let tokenURL     = "https://unsplash.com/oauth/token"
        //static let redirectURL = "urn:ietf:wg:oauth:2.0:oob"
        static let redirectURL = "https://unsplashcollectionimages.com/authorize"

        struct Secrets {


            static let clientID: String = "Qy2zCD4_4BeQsxP1zYvZwp_ByovjR3rQXjjFMbAelkI"
            static let clientSecret: String = "PBTHaCF1tnLTrUikjtvRLbCu5qv6HaVQCe9mciCybpo"

//            static let clientID: String = "8ef42698e366832076e1ab8e822fe441141239a022dda4f1d8c07c83547d6ac6"
//            static let clientSecret: String = "61e99a9de0aca194722a0e0a668be33912ff97317f2a9b5a6ee0c0b4c788f06f"
        }
    }
}
