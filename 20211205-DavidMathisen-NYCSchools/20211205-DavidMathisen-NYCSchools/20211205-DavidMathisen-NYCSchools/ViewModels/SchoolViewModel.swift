//
//  SchoolViewModel.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import Foundation

class SchoolViewModel : NSObject {
    
    private var apiService : APIService!
    
    var school : School!
    
    private(set) var schoolSATData : SchoolSATData! {
        didSet {
            self.bindSchoolSATDataToController()
        }
    }
    
    var bindSchoolSATDataToController : (() -> ()) = {}
    
    init(school: School) {
        super.init()
        
        self.school = school
        self.apiService = APIService()
        
        callFuncToGetSchoolSATData()
    }
    
    //Call API service to get SAT scores
    func callFuncToGetSchoolSATData() {
        self.apiService.apiGetSchoolSATData(dbn: school.dbn) { (schoolSATData) in
            self.schoolSATData = schoolSATData
        }
    }
}
