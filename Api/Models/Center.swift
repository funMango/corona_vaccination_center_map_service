//
//  Model.swift
//  Api
//
//  Created by 이민호 on 2023/10/29.
//

import Foundation

struct CenterResponse: Codable {
    let data: [Center]
}

struct Center: Codable {
    let id: Int
    let centerName: String
    let sido: String
    let sigungu: String
    let facilityName: String
    let zipCode: String
    let address: String
    let lat: String
    let lng: String
    let createdAt: String
    let updatedAt: String
    let centerType: String
    let org: String
    let phoneNumber: String
}
