//
//  EpisodesTableViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit

class EpisodesTableViewController: UITableViewController {
    
    var podcastId:String?
    var service:PodCastService = PodCastService()
    var podcast:PodCastEpisodesResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem
        
        
        
        guard let id = podcastId else{
            self.dismiss(animated: true)
            return
        }
        
        uiConfiguration()
        
        callAPI(id)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return podcast?.episodes.count ?? 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodescell", for: indexPath) as! EpisodesTableViewCell

        // Configure the cell...
//        cell.textLabel?.text = "\(String(describing: podcast?.episodes[indexPath.row].title)) eita \(indexPath.row)"
        guard let episode:Episode = podcast?.episodes[indexPath.row] else{
            return cell
        }
        cell.prepare(episode)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
        self.title = podcast?.title
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        header.backgroundColor = .red
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let filter = UIView()
        filter.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        filter.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageUrl = URL(string: podcast?.image ?? ""){
            URLSession.shared.dataTask(with: imageUrl){data, _, error in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
                
            }.resume()
        }else{
            imageView.image = UIImage(named: "imagePlaceholder")
        }
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.center = CGPoint(x: 50, y: 50)
        title.textAlignment = .center
        
        title.text = podcast?.title ?? ""
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .white
        
        let episodios = UILabel()
        episodios.translatesAutoresizingMaskIntoConstraints = false
        episodios.textAlignment = .center
        episodios.text = "Episódios: \(String(describing: podcast?.totalEpisodes ?? 0))"
        episodios.font = episodios.font.withSize(16)
        episodios.textColor = .white
              
        
        header.addSubview(imageView)
        header.addSubview(filter)
        header.addSubview(title)
        header.addSubview(episodios)
        
        NSLayoutConstraint.activate([
            
            header.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            header.heightAnchor.constraint(equalToConstant: 200),
        
            
            imageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            filter.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            filter.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            filter.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            filter.heightAnchor.constraint(equalToConstant: 200),
            
            
            title.heightAnchor.constraint(equalToConstant: 35),
            title.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            title.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: 51),


            episodios.heightAnchor.constraint(equalToConstant: 35),
            episodios.widthAnchor.constraint(equalTo: header.widthAnchor),
            episodios.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            episodios.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -51),
            
            
            
        ])
        
        return header
    }

}

extension EpisodesTableViewController{
    func callAPI(_ id:String){
        service.getepisodes(id) { [weak self] result in
            guard let self = self else{return}
            
            switch result{
            case .success(let response):
                podcast = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func uiConfiguration(){
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 400))
//        header.backgroundColor = .red
//
//        tableView.tableHeaderView = header
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.navigationBar.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0)
        
        if var textatribute = self.navigationController?.navigationBar.titleTextAttributes{
            textatribute[NSAttributedString.Key.foregroundColor] = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = textatribute
        }
        
    }
}
