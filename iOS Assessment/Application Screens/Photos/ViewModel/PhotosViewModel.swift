//
//  PhotosViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol PhotosViewModelInputs {
    func fetchPhotos()
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol
    func fetchMorePhotosIfAvailable(at row: Int)
    func adTitle(atRow row: Int) -> String
    
    func adRow(for indexPath: IndexPath) -> Int?
    func photoRow(for indexPath: IndexPath) -> Int?
    func didSelectRow(at indexPath: IndexPath)
}

protocol PhotosViewModelOutputs {
    var showLoading: ( (_ show: Bool) -> Void )? { get set }
    var reloadData: ( () -> Void )? { get set }
    var numberOfItems: Int { get }
    var failureAlert: ( (_ message: String) -> Void )? { get set }
    var showPhotoInFullScreen: ( (PhotoDetailsViewModelProtocol) -> Void )? { get set }
}

protocol PhotosViewModelProtocol: AnyObject {
    var inputs: PhotosViewModelInputs { get }
    var outputs: PhotosViewModelOutputs { get set }
}

class PhotosViewModel: PhotosViewModelInputs, PhotosViewModelOutputs, PhotosViewModelProtocol {
    
    var inputs: PhotosViewModelInputs { self }
    var outputs: PhotosViewModelOutputs {
        get { self }
        set { }
    }
    
    private let provider: PicsumProviding
    private let photosCashingProvider: PhotosCashingProviding
    private var photos: [Photo] = []
    private var page: Int = 1
    private var isGettingPhotos: Bool = false
    private var didFetchLastPage: Bool = false
    private var isconnectedToInternet: Bool = true
    private var ads: [String] = []
    private let AD_INTERVAL = 6
    private var localDataLoaded: Bool = false
    
    init(provider: PicsumProviding = PicsumProvider(),
         photosCashingProvider: PhotosCashingProviding = PhotosCashingProvider()){
        
        self.provider = provider
        self.photosCashingProvider = photosCashingProvider
        
        Monitor().startMonitoring { [weak self] isReachable in
            guard let self = self else { return }
            self.isconnectedToInternet = isReachable
        }
    }
    
    /// Inputs
    
    func fetchPhotos(){
        isGettingPhotos = true
        showLoading?(true)
        provider.photos(forPage: page, withLimit: 10) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .failure(let error):
                self.loadLocalPhotosDataIfNeeded()
                self.failureAlert?(error.errorDescription ?? "Unexpected error.")
                
            case .success(let photos):
                self.handle(photos: photos)
                self.prepareAdsData()
                self.reloadData?()
            }
            
            self.isGettingPhotos = false
            self.showLoading?(false)
        }
    }
    
    private func handle(photos: [Photo]){
        // If photos returned as an empty array so we are at the last page.
        self.didFetchLastPage = photos.isEmpty
        
        if self.page == 1 { self.photos = photos }
        else { self.photos.append(contentsOf: photos) }
        
        if page == 1 || page == 2{
            self.storePhotosDataLocally()
        }
    }
    
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol{
        PhotoCellViewModel(photo: photos[row])
    }
    
    /// Will Fetch More Data If This all the conditions is passed to avoid Fetching photos again and again.
    func fetchMorePhotosIfAvailable(at row: Int){
        guard isconnectedToInternet else { return }
        guard !isGettingPhotos else { return }
        guard (row + 1) == numberOfItems else { return }
        guard !didFetchLastPage else { return }
        page += 1
        
        // To Make Sure that when internet connection is retrived to
        // clear the data and begin from page 1 to avoid dublications.
        if localDataLoaded {
            localDataLoaded = false
            self.photos.removeAll()
            self.page = 1
        }
        
        self.fetchPhotos()
    }
    
    /// Preparing Ads data so that we can add an ad every 5 photos.
    func prepareAdsData(){
        var values = [String]()
        for _ in stride(from: 0, to: photos.count, by: self.AD_INTERVAL - 1) {
            values.append("Extend the reach of your brand")
        }
        self.ads = values
    }
    
    /// Get the correct index for photo from the indexPath according to ad Interval
    func photoRow(for indexPath: IndexPath) -> Int? {
        let (quotient, remainder) = (indexPath.row + 1).quotientAndRemainder(dividingBy: AD_INTERVAL)
        if remainder == 0 { return nil }
        return quotient * (AD_INTERVAL - 1) + remainder - 1
    }
    
    /// Get the correct index for ad from the indexPath according to ad Interval
    func adRow(for indexPath: IndexPath) -> Int? {
        let (quotient, remainder) = (indexPath.row + 1).quotientAndRemainder(dividingBy: AD_INTERVAL)
        if remainder != 0 { return nil }
        return quotient - 1
    }
    
    func adTitle(atRow row: Int) -> String{ ads[row] }
    
    /// Load photos when there is no internet connection.
    func loadLocalPhotosDataIfNeeded(){
        // Will Load From Local Only if photos array is empty.
        guard photos.isEmpty else { return }
        
        photosCashingProvider.loadIfExist { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            self.localDataLoaded = true
            self.prepareAdsData()
            self.reloadData?()
        }
    }
    
    /// Saving photos locally for offline Mode.
    func storePhotosDataLocally(){
        photosCashingProvider.store(photos: photos)
    }
    
    func didSelectRow(at indexPath: IndexPath){
        guard let row = photoRow(for: indexPath) else { return }
        let viewModel = PhotoDetailsViewModel(photo: photos[row])
        showPhotoInFullScreen?(viewModel)
    }
    
    /// OutPuts
    
    var showLoading: ( (_ show: Bool) -> Void )?
    var reloadData: ( () -> Void )?
    var numberOfItems: Int { photos.count + ads.count }
    var failureAlert: ((String) -> Void)?
    var showPhotoInFullScreen: ( (PhotoDetailsViewModelProtocol) -> Void )?
}
