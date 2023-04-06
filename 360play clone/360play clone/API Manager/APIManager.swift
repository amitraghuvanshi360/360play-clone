//
//  APIManager.swift
//  360play clone
//
//  Created by Ankush Sharma on 29/03/23.
//

import Foundation

typealias completionHandler = (Payment) -> Void
typealias success = (Payment) -> Void
//


class APIManager{
    static let PAYMENT_TYPE = "/Service/List_Payment_Type"
    static let AGE_GROUP = "/Service/List_AgeGroup"
    static let LIST_GAMES = "/Service/ListGames"
    static let GAME_SLOTS = "/Service/GetServiceOption"
    static let USER_SIGNIN = "/User/SignIn"
    
    class func paymentTypeAPIRequest(completion: @escaping completionHandler){
        let base_url = "\(Constant.BASE_URL)\(PAYMENT_TYPE)"
        guard let url = URL.init(string: base_url) else {
            return
        }
        
        let urlRequest = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data , response , error in
            
            if let errors = error{
                print(errors.localizedDescription)
            }
            
            guard let httpResponse = response else {
                print("Error in response: \(response)")
                return
            }
            
            if let data = try? JSONDecoder().decode(Payment.self, from: data! ) {
                completion(data)
            }
            
        }).resume()
    }
    
    
    class func ageGroupAPIRequest(completion:@escaping (Group) -> Void ) {
        
        let base_url = "\(Constant.BASE_URL)\(AGE_GROUP)"
        guard let url = URL.init(string: base_url) else {
            return
        }
        
        let urlRequest = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data , response , error in
            
            if let errors = error{
                print(errors.localizedDescription)
            }
            
            guard let httpResponse = response else {
                print("Error in response: \(response)")
                return
            }
            
            if let data = try? JSONDecoder().decode(Group.self, from: data! ) {
                completion(data)
            }
            
        }).resume()
    }
    
    class func gameListAPIRequest(completion:@escaping (Game) -> Void ) {
        
        let base_url = "\(Constant.BASE_URL)\(LIST_GAMES)?userId=22"
        guard let url = URL.init(string: base_url) else {
            return
        }
        
        let urlRequest = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data , response , error in
            
            if let errors = error{
                print(errors.localizedDescription)
            }
            
            guard let httpResponse = response else {
                print("Error in response: \(response)")
                return
            }
            
            if let data = try? JSONDecoder().decode(Game.self, from: data! ) {
                completion(data)
            }
        }).resume()
    }
    
    class func userAuthenticationRequest(email:String , password:String, completion:@escaping (User?, String?) -> Void) {
        let base_url = "\(Constant.BASE_URL)\(USER_SIGNIN)"
        guard let url = URL.init(string: base_url) else {
            return
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        
        let params :[String: Any] = ["email" : email, "password" : password]
        let postStr = self.getPostString(params: params)
        urlRequest.httpBody = postStr.data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data , response , error in
            if let errors = error {
                print(errors.localizedDescription)
            }
            
            guard let dataUnwarpped = data else {
                print("Error in Data")
                return
            }
            //self.convertToDictionary1(data: dataUnwarpped)
            if let dataObj = try? JSONDecoder().decode(UserAuthentication.self, from: dataUnwarpped ) {
                
                if let modelData = dataObj.data {
                    completion(modelData.first, nil)
                } else {
                    completion(nil, dataObj.statusMessage)
                }
                
                
            }
        }).resume()
    }
    
    class func getGameSlotRequest(gameId: Int, completion:@escaping (GameSlot?) -> Void){
        let base_url = "\(Constant.BASE_URL)\(GAME_SLOTS)?gameId=\(gameId)"
        guard let url = URL.init(string: base_url) else {
            return
        }
        
        let urlRequest = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data , response , error in
            if let errors = error{
                print(errors.localizedDescription)
            }
            
            guard let dataUnwarpped = data else {
                print("Error in Data")
                return
            }
            if let dataObj = try? JSONDecoder().decode(GameSlot.self, from: dataUnwarpped ) {
                print(dataObj)
                completion(dataObj)
            }
        }).resume()
    }
    
    class func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}




//extension {
//    class func convertToDictionary1(data: Data) {
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] // [Any]
//            print(json)
//        } catch {
//            print("errorMsg")
//        }
//    }
//}
