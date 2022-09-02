//
//  ListViewControllerTest.swift
//  JSONPlaceholder TestTests
//
//  Created by Pedro Andres Villamil on 1/09/22.
//

import XCTest

@testable import JSONPlaceholder_Test
final class ListViewControllerTest: XCTestCase {

    func testRegisteredCells() {
        let tableView = makeSut().getTableView()
        let cell: UITableViewCell? = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: IndexPath(index: 0)
        )
        XCTAssertNotNil(cell)
    }
    
    
    // MARK: helpers
    private func makeSut() -> PostsViewController {
        let sut = PostsViewController()
        sut.presenter = TestPostPresenter()
        triggerViewControllerLifeCycle(for: sut)
        return sut
    }
}

extension ListViewControllerTest {

    class TestPostPresenter: PostsPresenterInterface {
        var numberOfItems: Int = 0
        var postNumber: Int = 0
        func deleteAllList() { }
        func deleteIteam(at indexPath: IndexPath) { }
        func didSelectItem(at indexPath: IndexPath) { }
        func item(at indexPath: IndexPath) -> PostCellViewModel? { return nil }
        func loadNextPage() { }
        func refreshList() { }
        func toggleFavoriteInPost(at indexPath: IndexPath) { }
        func viewDidLoad() { }
    }
}

extension XCTestCase {
    
    func createViewControllerFromStoryBoard<T: UIViewController>(nameStoryboard: String) -> T? {
        let storyboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "\(T.self)") as? T
    }
    
    func triggerViewControllerLifeCycle(for viewController: UIViewController ) {
        _ = viewController.view
        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()
    }
}
