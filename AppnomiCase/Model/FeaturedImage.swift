//
//  FeaturedImage.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
struct FeaturedImage: Codable {
    let typ, nyp: String?
    enum CodingKeys: String, CodingKey {
        case typ = "t"
        case nyp = "n"
    }
}
