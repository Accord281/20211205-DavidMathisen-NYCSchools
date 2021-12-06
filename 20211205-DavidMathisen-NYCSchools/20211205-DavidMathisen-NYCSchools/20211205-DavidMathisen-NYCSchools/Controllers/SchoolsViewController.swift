//
//  SchoolsViewController.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import UIKit

class SchoolsViewController: UIViewController {
    
    @IBOutlet weak var schoolTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var schoolsViewModel : SchoolsViewModel!
    
    private var dataSource : SchoolsTableViewDataSource<SchoolTableViewCell,School>!
    
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYC Schools"
        
        self.searchBar.delegate = self
        self.schoolTableView.delegate = self
        
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        self.schoolsViewModel = SchoolsViewModel()
        self.schoolsViewModel.bindSchoolListViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
            
        if searching {
            //Use the filtered list of schools
            self.dataSource = SchoolsTableViewDataSource(cellIdentifier: "SchoolTableViewCell", items: self.schoolsViewModel.searchedSchoolListData.schoolList, configureCell: { (cell, sch) in
                    cell.schoolNameLabel.text = sch.schoolName
                }
            )
        } else {
            //Use the full list of schools
            self.dataSource = SchoolsTableViewDataSource(cellIdentifier: "SchoolTableViewCell", items: self.schoolsViewModel.schoolListData.schoolList, configureCell: { (cell, sch) in
                    cell.schoolNameLabel.text = sch.schoolName
                }
            )
        }
            
        DispatchQueue.main.async {
            self.schoolTableView.dataSource = self.dataSource
            self.schoolTableView.reloadData()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "schoolsDetailsViewSegue" {
            //verify that there is a row selected in the table
            guard (schoolTableView.indexPathForSelectedRow?.row) != nil else {
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "schoolDetailsViewSegue" {
            //We have already ensured this is not nil in shouldPerformSegue, so we can force unwrap later
            let index = schoolTableView.indexPathForSelectedRow?.row
            
            if searching {
                //Select the school from the filtered list. If we had sorting or additional filters, this would need to be redone.
                let selectedSchool = schoolsViewModel.searchedSchoolListData.schoolList[index!]
                schoolsViewModel.selectedSchool = selectedSchool
            } else {
                //Select the school from the full list.
                let selectedSchool = schoolsViewModel.schoolListData.schoolList[index!]
                schoolsViewModel.selectedSchool = selectedSchool
            }
            
            //Set the school on the SchoolsViewController so that the view model can pick it up.
            if let destinationVC = segue.destination as? SchoolViewController {
                destinationVC.school = schoolsViewModel.selectedSchool
            }
        }
    }
}

extension SchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolTableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SchoolsViewController: UISearchBarDelegate {
    
    //given more time, I would make the search use a "like" format instead of search from beginning
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        schoolsViewModel.searchSchools(searchText: searchText)
        searching = true
        schoolTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        schoolTableView.reloadData()
    }
}

