//
//  APIService.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import Foundation

class APIService : NSObject {
    
    //Get a list of NYC Schools
    func apiGetSchoolList(completion : @escaping ([School]) -> ()) {
        let urlString: String = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                    if let data = data {
                        
                        let jsonDecoder = JSONDecoder()
                        
                        let schoolListData = try! jsonDecoder.decode([School].self, from: data)
                            completion(schoolListData)
                    }
                }.resume()
    }
    
    //Get the SAT scores for a school using the DBN
    func apiGetSchoolSATData(dbn: String, completion : @escaping (SchoolSATData) -> ()) {
        let urlString: String = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=" + dbn
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                    if let data = data {
                        
                        let jsonDecoder = JSONDecoder()
                        
                        let schoolSATData = try! jsonDecoder.decode([SchoolSATData].self, from: data)
                        completion(schoolSATData.first ?? SchoolSATData(dbn: dbn, schoolName: "", numTakers: "0", readingAvgScore: "0", mathAvgScore: "0", writingAvgScore: "0"))
                    }
                }.resume()
    }
}
