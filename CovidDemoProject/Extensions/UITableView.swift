//
//  UITableView.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//
import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
}

