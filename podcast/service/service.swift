//
//  service.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 07/04/23.
//

import Foundation
import PodcastAPI


class PodCastService{
    let apikey = "82d39f47182148a9b5740c8571880154"//ProcessInfo.processInfo.environment["LISTEN_API_KEY", default: ""]
    let client:Client!
   
    
    init() {
        self.client = PodcastAPI.Client(apiKey: self.apikey, synchronousRequest: true)
    }
    
    func search(query:String){
        var parameters:[String:String] = [:]
        parameters["q"] = query
        parameters["sort_by_date"] = "1"
        parameters["region"] = "br"
        
        client.search(parameters: parameters){ response in
            
            if let error = response.error{
                switch error {
                case PodcastApiError.apiConnectionError:
                    print("Não foi possivel conectar ao servidor")
                case PodcastApiError.authenticationError:
                    print("Api Key errada")
                default:
                    print("erro desconhecido")
                }
            }else{
                if let json = response.toJson(){
                    print(json)
                }
                
                print(response.getFreeQuota())
                print(response.getUsage())
                print(response.getNextBillingDate())
            }
            
        }
    }
    
    func getBestPod(completion: @escaping (Result<[UrlPodcast], PodcastApiError>)->Void){
        var parameters:[String:String] = [:]
        parameters["region"] = "br"
        parameters["publisher_region"] = "br"
        parameters["safe_mode"] = "0"
        parameters["sort"] = "listen_score"
        
        
        
        client.fetchBestPodcasts(parameters: parameters){ response in
            
            if let error = response.error{
                switch error {
                case PodcastApiError.apiConnectionError:
                    print("Não foi possivel conectar ao servidor")
                case PodcastApiError.authenticationError:
                    print("Api Key errada")
                default:
                    print("erro desconhecido")
                }
                completion(.failure(error))
                
            }else{
                
                if let json = response.toJson(){
                    
                    let jsonString: String =  (json as AnyObject).description
                    let jsonData = Data(jsonString.utf8)
                    do{
                        
                       
                        
                        let decocder = JSONDecoder()
                        let bestPodCastResponse = try decocder.decode(BestPodCastResponse.self, from: jsonData)
                        
                        completion(.success(bestPodCastResponse.podcasts))
                        
                    }catch{
                        print("ERROR: \(error.localizedDescription)")
                        completion(.failure(.invalidRequestError))
                    }
                }
                
                print(response.getFreeQuota())
                print(response.getUsage())
                print(response.getNextBillingDate())
            }
            
        }
    }
    
    func getepisodes(_ id:String, completion: @escaping(Result<PodCastEpisodesResponse, PodcastApiError>)->Void){
        var parameters: [String: String] = [:]
        parameters["id"] = id
        
        client.fetchPodcastById(parameters: parameters) { response in
            if let error = response.error{
                switch error {
                case PodcastApiError.apiConnectionError:
                    print("Não foi possivel conectar ao servidor")
                case PodcastApiError.authenticationError:
                    print("Api Key errada")
                default:
                    print("erro desconhecido")
                }
                completion(.failure(error))
                
            }else{
                if let json = response.toJson(){
                    
                    let jsonString: String =  (json as AnyObject).description
                    let jsonData = Data(jsonString.utf8)
                    do{
                        let decocder = JSONDecoder()
                        let epsodesresponse = try decocder.decode(PodCastEpisodesResponse.self, from: jsonData)
                        
                        completion(.success(epsodesresponse))
                    }catch{
                        print("ERROR: \(error.localizedDescription)")
                        completion(.failure(.invalidRequestError))
                    }
                    
                }
            }
        }
    }
    
}
