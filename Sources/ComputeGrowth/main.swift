import Foundation


// Temporary name


enum GrowthType {
    case linear, exponential
}

struct GrowthData {
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
}

struct Growth {
    var linear: GrowthData
    var exponential: GrowthData
    var start: Int
    var description: String {
        var pointInTime = start
        var output = header()
        
        for i in (0...Int.max) {
            let linearValue = linear.value(atTime: i)
            let exponentialValue = exponential.value(atTime: i)
            
            output += (String(format: "| %-12d | %-12.2f | %-12.2f |\n",
                         pointInTime,
                         linearValue,
                         exponentialValue))
            if linearValue < exponentialValue { break }
            pointInTime +=  1
        }
        return output
    }
    
    init(linear: GrowthData, exponential: GrowthData, start: Int) {
        self.linear = linear
        self.exponential = exponential
        self.start = start
    }
    
    // TODO: extract printing from this type?
    // Definitely refactor this this is ugly
    // Maybe define a print table Type
    func header() -> String {
        return String(format: "%@\n| % 12@ | % 12@ | % 12@ |\n%@",
                     String(repeating: "-", count: 12 * 3 + 4 + 6),
                     "x".padding(toLength: 12, withPad: " ", startingAt: 0),
                     "linear".padding(toLength: 12, withPad: " ", startingAt: 0),
                     "exponential".padding(toLength: 12, withPad: " ", startingAt: 0),
                     String(repeating: "-", count: 12 * 3 + 4 + 6)) + "\n"
    }
}


let linear = GrowthData(initialValue: 25_000, growth: 500, type: .linear)
let exponential = GrowthData(initialValue: 20_000, growth: 1.05, type: .exponential)
let growth = Growth(linear: linear, exponential: exponential, start: 1)
print(growth.description)


