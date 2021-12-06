//
//  SchoolsViewModel.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import Foundation

class SchoolsViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var schoolListData : Schools! {
        didSet {
            self.bindSchoolListViewModelToController()
        }
    }
    
    private(set) var searchedSchoolListData : Schools! {
        didSet {
            self.bindSchoolListViewModelToController()
        }
    }
    
    var selectedSchool : School?
    
    var bindSchoolListViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetSchoolData()
    }
    
    func callFuncToGetSchoolData() {
        self.apiService.apiGetSchoolList { (schoolListData) in
            self.schoolListData = Schools(schoolList: schoolListData.sorted(by: {$0.schoolName < $1.schoolName}))
        }
    }
    
    func searchSchools(searchText: String) {
        searchedSchoolListData = Schools(schoolList: schoolListData.schoolList.filter { $0.schoolName.lowercased().prefix(searchText.count) == searchText.lowercased() })
    }
}
