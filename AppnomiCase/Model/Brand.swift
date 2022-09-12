//
//  Brand.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

struct Brand: Codable {
    let id, name: String?
    let icon: FeaturedImage?
    let isActive: Bool?
    let createDate, updateDate: String?
}
