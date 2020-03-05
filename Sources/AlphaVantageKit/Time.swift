//
//  Time.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

public struct Time : Equatable {
    public let hour: Int8
    public let minute: Int8
    public let second: Int8
    
    public static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.hour == rhs.hour && lhs.minute == rhs.minute && lhs.second == rhs.second
    }
}
