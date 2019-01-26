import Foundation

// TODO: refactor furthermore since both linear and
// exponential are tight toghether they should be part of the same type
// This will avoid weird print call on the type itself.
// and have an external shared starting point in time.
// This would also simply initialisation of growth.
struct Growth {
    
    enum GrowthType {
        case exponential, linear
    }
    
    var initialValue = 0.0
    var growth = 0.0
    var type: GrowthType
    
    init(initialValue: Double, growth: Double, type: GrowthType) {
        self.initialValue = initialValue
        self.growth = growth
        self.type = type
    }
    
    public func value(atTime: Int) -> Double {
        switch type {
        case .linear:
            return initialValue + growth * Double(atTime)
        case .exponential:
            return initialValue * pow(growth, Double(atTime))
        }
    }
    
    static func printResult(linear: Growth, exponential: Growth, start: Int) {
        
        var year = start
        var index = 0
        
        printHeader()
        
        while true {
            let linearComponent = linear.value(atTime: index)
            let exponentialComponent = exponential.value(atTime: index)
            
            print(String(format: "| %-12d | %-12.2f | %-12.2f |", year,
                         linearComponent,
                         exponentialComponent))
            if linearComponent < exponentialComponent {
                break
            }
            
            index +=  1
            year +=  1
        }
    }
    
    // TODO: extract printing from this type?
    // Definitely refactor this this is ugly
    static func printHeader() {
        print(String(format: "%@\n| % 12@ | % 12@ | % 12@ |\n%@",
                     String(repeating: "-", count: 12 * 3 + 4 + 6),
                     "x".padding(toLength: 12, withPad: " ", startingAt: 0),
                     "linear".padding(toLength: 12, withPad: " ", startingAt: 0),
                     "exponential".padding(toLength: 12, withPad: " ", startingAt: 0),
                     String(repeating: "-", count: 12 * 3 + 4 + 6)))
    }
}


let linear = Growth(initialValue: 25_000, growth: 500, type: .linear)
let exponential = Growth(initialValue: 20_000, growth: 1.05, type: .exponential)
let startingYear = 1

Growth.printResult(linear: linear, exponential: exponential, start: startingYear)
