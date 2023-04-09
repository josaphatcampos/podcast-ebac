//
//  HomeViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit

protocol FavoriteDelegate{
    func favoritarPodCast(_ id:String)
    func desfavoritarPodCast(_ id:String)
}

class HomeViewController: UIViewController {
    
    var service:PodCastService = PodCastService()
    var pod:[Podcast] = []
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var banner: UIImageView!
    
    @IBOutlet weak var hometableview: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    
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
            guard let self = self else{return}
            
            switch result{
            case .success(let response):
                for item in response {
                    self.pod.append(item)
                }
                
                self.tableviewHeight.constant = CGFloat(80 * (self.pod.count))
                
                DispatchQueue.main.async {
                    self.hometableview.reloadData()
                }
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func callPodcastEpisodes(_ id:String){
        //epsodesTableView
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "epsodesTableView") as! EpisodesTableViewController
            controller.podcastId = id
            
            let navController = UINavigationController(rootViewController: controller)
//            navController.modalPresentationStyle = .fullScreen
            
            self.present(navController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeCellTableViewCell
        let podcast = pod[indexPath.row]
        
        cell.favoriteDelegate = self
        cell.id = podcast.id
        
        cell.prepare(with: podcast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("celula \(indexPath)")
        callPodcastEpisodes(pod[indexPath.row].id)
    }    
}

extension HomeViewController: FavoriteDelegate{
    func desfavoritarPodCast(_ id: String) {
        print("Voce Desavoritou o \(id)")
    }
    
    func favoritarPodCast(_ id: String) {
        print("Voce Favoritou o \(id)")
    }
    
    
}
