//
//  GenericDataSource.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import Foundation
import UIKit

/// Genenic datasource class with Dynamic values
/// Auto notify and update UI on data change
/// Mapping response data in a generic object extended with tableview datasource to present data in a list


class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
