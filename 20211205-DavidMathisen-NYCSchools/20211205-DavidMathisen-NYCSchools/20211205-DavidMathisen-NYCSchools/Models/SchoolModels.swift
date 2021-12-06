//
//  SchoolModels.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import Foundation

struct Schools: Decodable {
    let schoolList: [School]
}

//There are many more fields coming in, but for the sake of simplicity we will only use a few
struct School: Decodable {
    let dbn, schoolName: String
    let location, totalStudents, graduationRate: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case location
        case totalStudents = "total_students"
        case graduationRate = "graduation_rate"
    }
    
    var gradPercent: String? {
        String(Int(round((Double(graduationRate ?? "0") ?? 0) * 100))) + "%"
    }
}
