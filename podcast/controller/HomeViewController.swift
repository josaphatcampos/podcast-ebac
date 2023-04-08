//
//  HomeViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var service:PodCastService = PodCastService()
    var pod:[Podcast] = []
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var banner: UIImageView!
    
    @IBOutlet weak var hometableview: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hometableview.dataSource = self
        hometableview.delegate = self
        viewConfig()
        callAPI()
    }
    
    func viewConfig(){
//        scrollview.contentSize = CGSizeMake(scrollViewContentWidth, scrollViewContentHeight)
        hometableview.bounces = false
        hometableview.isScrollEnabled = false
        
    }
    
    func callAPI(){
        service.getBestPod { [weak self] result in
            guard let selg = self else{return}
            
            switch result{
            case .success(let response):
                for item in response {
                    self!.pod.append(item)
                }
                
                DispatchQueue.main.async {
                    self?.hometableview.reloadData()
                }
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeCellTableViewCell
        
        cell.prepare(with:  pod[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("celula \(indexPath)")
    }
    
    
    
    

    
}
