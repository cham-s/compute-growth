import Foundation

enum Type {
    case exponential, linear
}

struct FunctionData {
    
    var initialValue = 0
    var growth = 0
    var type: Type
    
    init(initialValue: Int, growth: Int, type: Type) {
        self.initialValue = initialValue
        self.growth = growth
        self.type = type
    }
}

func yearlyValue(from data: FunctionData,and year: Int) -> Int {
    switch data.type {
    case .linear:
        return data.initialValue + data.growth * year
    case .exponential:
        return data.initialValue * Int(pow(Double(data.growth), Double(year)))
    }
}


// TODO: refactor obviously
func printHeader() {
    print(String(format: "| % 12@ | % 12@ | % 12@ |\n%@",
                 "x".padding(toLength: 12, withPad: " ", startingAt: 0),
                 "linear".padding(toLength: 12, withPad: " ", startingAt: 0),
                 "exponential".padding(toLength: 12, withPad: " ", startingAt: 0),
                 String(repeating: "-", count: 12 * 3 + 4 + 6)))
}

func printResult(linear: FunctionData,
                 exponential: FunctionData,
                 startingYear: Int) {
    
    var year = startingYear
    

    
    for i in (0...Int.max) {
        let linearComponent = yearlyValue(from: linear, and: i)
        let exponentialComponent = yearlyValue(from: exponential, and: i)
        
        guard linearComponent > exponentialComponent else {
            return
        }
        
        print(String(format: "| %-12d | %-12d | %-12d |", year,
                     linearComponent,
                     exponentialComponent))
        year += 1
    }
}

let linear = FunctionData(initialValue: 5, growth: 11, type: .linear)
let exponential = FunctionData(initialValue: 2, growth: 3, type: .exponential)
let startingYear = 1

printResult(linear: linear, exponential: exponential)
