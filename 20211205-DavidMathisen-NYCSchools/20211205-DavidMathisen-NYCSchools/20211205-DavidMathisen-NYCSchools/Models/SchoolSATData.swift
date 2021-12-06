//
//  SchoolSATData.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import Foundation

struct SchoolSATData: Decodable {
    let dbn, schoolName, numTakers, readingAvgScore, mathAvgScore, writingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numTakers = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
    
    var readingAvgScoreString: String? {
        if (Double(readingAvgScore) ?? 0) > 0 {
            return readingAvgScore
        } else {
            return "Unavailable"
        }
    }
    
    var mathAvgScoreString: String? {
        if (Double(mathAvgScore) ?? 0) > 0 {
            return mathAvgScore
        } else {
            return "Unavailable"
        }
    }
    
    var writingAvgScoreString: String? {
        if (Double(writingAvgScore) ?? 0) > 0 {
            return writingAvgScore
        } else {
            return "Unavailable"
        }
    }
}
