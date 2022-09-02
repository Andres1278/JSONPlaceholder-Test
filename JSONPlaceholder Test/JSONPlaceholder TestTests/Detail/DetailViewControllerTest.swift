//
//  DetailViewControllerTest.swift
//  JSONPlaceholder TestTests
//
//  Created by Pedro Andres Villamil on 1/09/22.
//

import XCTest

@testable import JSONPlaceholder_Test
final class DetailViewControllerTest: XCTestCase {

    func testRegisteredCells() {
        let tableView = makeSut().getTableView()
        var cellList: [UITableViewCell?] = []
        cellList.append(tableView.dequeueReusableCell(
            withIdentifier: PostInfoTableViewCell.reuseIdentifier,
            for: IndexPath(index: 0)
        ))
        cellList.append(tableView.dequeueReusableCell(
            withIdentifier: UserInfoTableViewCell.reuseIdentifier,
            for: IndexPath(index: 0)
        ))
        cellList.append(tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.reuseIdentifier,
            for: IndexPath(index: 0)
        ))
        cellList.forEach { cell in
            XCTAssertNotNil(cell)
        }
    }
    
    func testRegisteredHeaderFooterView() {
        let tableView = makeSut().getTableView()
        var header: UITableViewHeaderFooterView? = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: DetailPostHeader.reuseIdentifier
        )
        XCTAssertNotNil(header)
    }
    
    
    
    // MARK: helpers
    private func makeSut() -> PostDetailViewController {
        let sut = PostDetailViewController()
        sut.presenter = TestPostDetailPresenter()
        triggerViewControllerLifeCycle(for: sut)
        return sut
    }
}

extension DetailViewControllerTest {

    class TestPostDetailPresenter: PostDetailPresenterInterface {
        
        var postId: Int = 0
        var numberOfSections: Int = 0
        var isFavorite: Bool = false
        func numberOfItems(in section: Int) -> Int { 0 }
        func item(at indexPath: IndexPath) -> PostDetailViewItemInterface? { return nil }
        func getSectionHeader(in section: Int) -> String? { return nil }
        func toggleFavoriteState() { }
        func viewDidLoad() { }
    }
}
