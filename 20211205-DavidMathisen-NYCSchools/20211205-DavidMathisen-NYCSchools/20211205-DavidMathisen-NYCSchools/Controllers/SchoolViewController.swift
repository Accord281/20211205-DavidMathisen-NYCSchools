//
//  SchoolViewController.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import UIKit

class SchoolViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var totalStudentsLabel: UILabel!
    @IBOutlet weak var graduationRateLabel: UILabel!
    @IBOutlet weak var avgWritingLabel: UILabel!
    @IBOutlet weak var avgMathLabel: UILabel!
    @IBOutlet weak var avgReadingLabel: UILabel!
    
    private var schoolViewModel : SchoolViewModel!
    public var school : School!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        self.schoolViewModel = SchoolViewModel(school: school)
        
        FillForm()
        
        self.schoolViewModel.bindSchoolSATDataToController = {
            self.updateData()
        }
    }
    
    func FillForm() {
        self.title = "School Information"
        
        //Fill in the school info we already have. We will get SAT scores from API in a bit.
        self.nameLabel.text = schoolViewModel.school.schoolName
        self.locationLabel.text = schoolViewModel.school.location
        self.totalStudentsLabel.text = schoolViewModel.school.totalStudents
        self.graduationRateLabel.text = schoolViewModel.school.gradPercent
    }
    
    func updateData(){
        DispatchQueue.main.async { //All UI updates must be done on main thread
            self.avgWritingLabel.text = self.schoolViewModel.schoolSATData.writingAvgScoreString
            self.avgMathLabel.text = self.schoolViewModel.schoolSATData.mathAvgScoreString
            self.avgReadingLabel.text = self.schoolViewModel.schoolSATData.readingAvgScoreString
        }
    }
}
