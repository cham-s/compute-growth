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
    print(String(format: "%@\n| % 12@ | % 12@ | % 12@ |\n%@",
                 String(repeating: "-", count: 12 * 3 + 4 + 6),
                 "x".padding(toLength: 12, withPad: " ", startingAt: 0),
                 "linear".padding(toLength: 12, withPad: " ", startingAt: 0),
                 "exponential".padding(toLength: 12, withPad: " ", startingAt: 0),
                 String(repeating: "-", count: 12 * 3 + 4 + 6)))
}

func printResult(linear: FunctionData,
                 exponential: FunctionData,
                 startingYear: Int) {
    
    var year = startingYear
    var index = 0
    
    printHeader()
    
    while true {
        let linearComponent = yearlyValue(from: linear, and: index)
        let exponentialComponent = yearlyValue(from: exponential, and: index)
        
        print(String(format: "| %-12d | %-12d | %-12d |", year,
                     linearComponent,
                     exponentialComponent))
        if linearComponent < exponentialComponent {
            break
        }
        
        index +=  1
        year +=  1
    }
}

let linear = FunctionData(initialValue: 5, growth: 11, type: .linear)
let exponential = FunctionData(initialValue: 2, growth: 3, type: .exponential)
let startingYear = 1

printResult(linear: linear, exponential: exponential, startingYear: startingYear)
