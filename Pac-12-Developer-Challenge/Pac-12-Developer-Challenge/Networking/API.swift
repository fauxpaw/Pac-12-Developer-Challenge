import Foundation

class API {
    
    var dataTask: URLSessionDataTask?
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    // MARK: Schools
    
    func getSchools(completion: @escaping (Result<SchoolsList, Error>) -> Void) {
        dataTask?.cancel()
        let urlComponents = URLComponents(string: "https://api.pac-12.com/v3/schools")
        guard let url = urlComponents?.url else { return }
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: url, completionHandler: {[weak self] data, response, error in
            
            if let error = error {
                completion(Result.failure(error))
            }
            
            else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let decodedSchools = try? self?.decoder.decode(SchoolsList.self, from: data)
                
                if let schools = decodedSchools {
                    completion(Result.success(schools))
                } else {
                    print("failure to decode schools")
                }
                
            }
        })
        dataTask?.resume()
    }
    
    // MARK: Sports
    
    func getSports(completion: @escaping (Result<SportsList, Error>) -> Void) {
        dataTask?.cancel()
        
        let urlComponents = URLComponents(string: "https://api.pac-12.com/v3/sports")
        guard let url = urlComponents?.url else { return }
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: url, completionHandler: {[weak self] data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                if let error = error {
                    completion(Result.failure(error))
                }
                return
            }
            let decodedSports = try? self?.decoder.decode(SportsList.self, from: data)
            if let sports = decodedSports {
                completion(Result.success(sports))
            } else {
                print("failure to decode sports")
            }
        })
        
        dataTask?.resume()
    }
    
    // MARK: Vods
    
    func getVods(route: String = "https://api.pac-12.com/v3/vod", completion: @escaping (Result<VodList, Error>) -> Void) {
        
        dataTask?.cancel()
        let urlComponents = URLComponents(string: route)
        guard let url = urlComponents?.url else { return }
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: url, completionHandler: {[weak self] data, response, error in
            
            if let error = error {
                completion(Result.failure(error))
            }
            
            else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let vods = try? self?.decoder.decode(VodList.self, from: data)
                
                if let vods = vods {
                    completion(Result.success(vods))
                } else {
                    print("failure to decode vods")
                }
                
            }
        })
        dataTask?.resume()
    }
}
