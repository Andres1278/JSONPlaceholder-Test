//
//  PostDetailPresenter.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 27/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PostDetailPresenter {

    // MARK: - Private properties -
    private unowned let view: PostDetailViewInterface
    private let interactor: PostDetailInteractorInterface
    private let wireframe: PostDetailWireframeInterface
    private var userInfomation: User?
    internal var comments: [Comment] = []
    private var fullPost: Post?
    var post: Post

    // MARK: - Lifecycle -
    init(view: PostDetailViewInterface, interactor: PostDetailInteractorInterface, wireframe: PostDetailWireframeInterface, post: Post) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.post = post
    }
    
    private func getPostInfo(with postId: Int, userId: Int) {
        
        let operationQueue = OperationQueue()
        let infoUserOperation = BlockOperation()
        let commentsOperation = BlockOperation()
        let detailOperation = BlockOperation()
        
        infoUserOperation.addExecutionBlock {
            self.interactor.getInfoUser(for: userId) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let userInfo):
                    strongSelf.userInfomation = userInfo
                    strongSelf.view.reloadView()
                case .failure(let error):
                    strongSelf.wireframe.showAlert(witn: error.localizedDescription)
                }
            }
        }
        
        commentsOperation.addExecutionBlock {
            self.interactor.getComments(for: postId) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let comments):
                    strongSelf.comments = comments
                    strongSelf.view.reloadView()
                case .failure(let error):
                    strongSelf.wireframe.showAlert(witn: error.localizedDescription)
                }
                
            }
        }
        
        detailOperation.addExecutionBlock {
            self.interactor.getDetail(for: postId) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let details):
                    strongSelf.fullPost = details
                    strongSelf.view.reloadView()
                case .failure(let error):
                    strongSelf.wireframe.showAlert(witn: error.localizedDescription)
                }
            }
        }
        
        commentsOperation.addDependency(infoUserOperation)
        detailOperation.addDependency(commentsOperation)
        
        operationQueue.qualityOfService = .utility
        operationQueue.addOperations(
            [infoUserOperation, commentsOperation, detailOperation],
            waitUntilFinished: false
        )
    }
}

// MARK: - Extensions -
extension PostDetailPresenter: PostDetailPresenterInterface {
    
    var postId: Int { post.id }
    var numberOfSections: Int { PostDetailSections.allCases.count }
    var isFavorite: Bool { post.isFavorite ?? false }

    func viewDidLoad() {
        getPostInfo(with: post.id, userId: post.userId)
    }
    
    func getSectionHeader(in section: Int) -> String? {
        switch PostDetailSections(rawValue: section) {
        case .postInfo: return "Post"
        case .userInfo: return "User"
        case .comments: return comments.isEmpty ? nil : "Comments"
        default: return nil
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch PostDetailSections(rawValue: section) {
        case .postInfo: return 1
        case .userInfo: return 1
        case .comments: return comments.isEmpty ? 5 : comments.count
        default: return .zero
        }
    }
    
    
    func item(at indexPath: IndexPath) -> PostDetailViewItemInterface? {
        switch PostDetailSections(rawValue: indexPath.section) {
        case .postInfo:
            guard let post = fullPost else { return PostDetailViewItemInterface.postInfo(nil) }
            return PostDetailViewItemInterface.postInfo(
                PostDetailCellViewModel(body: post.body, title: post.title)
            )
        case .userInfo:
            guard let user = userInfomation else { return PostDetailViewItemInterface.userInfo(nil) }
            return PostDetailViewItemInterface.userInfo(
                UserCellViewModel(
                    name: user.name,
                    email: user.email,
                    phone: user.phone,
                    website: user.website,
                    coordinates: user.address.geolocalization)
            )
        case .comments:
            guard let comment = comments.safeContains(indexPath.row) else {
                return PostDetailViewItemInterface.comments(nil)
            }
            return PostDetailViewItemInterface.comments(
                CommentCellViewModel(body: comment.body, email: comment.email)
            )
        default: return nil
        }
    }
    
    func toggleFavoriteState() {
        post.toggleFavorite()
    }
}
