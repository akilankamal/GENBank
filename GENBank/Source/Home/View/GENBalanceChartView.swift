//
//  GENBalanceChartView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI
import Charts

struct GENBalanceChartView: View {
    
    private enum KEYS {
        static let date                     = "date"
        static let balance                  = "balance"
    }
    
    // Transactions from Account details
    let transactions: [GENTransaction]
    
    // Range selected by user
    @State private var selectedRange: ChartRange = .oneMonth
    
    // Point on chart selected by user
    @State private var selectedSnapshot: (date: Date, balance: Double)?
    
    private var balanceHistory: [(date: Date, balance: Double)] {
        var history: [(Date, Double)] = []
        var running = 0.0
        let sorted = transactions.sorted { $0.timestamp < $1.timestamp }
        for tx in sorted {
            running += (tx.type == .credit ? tx.amount : -tx.amount)
            history.append((date: tx.timestamp, balance: running))
        }
        let cutoff = Calendar.current.date(byAdding: .day, value: -selectedRange.days, to: Date()) ?? Date()
        return history.filter { $0.0 >= cutoff }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ChartView()
                .chartOverlay { proxy in
                    ChartOverlayView(proxy)
                }
            
            ChartRangeSegment()
                .padding(.top, 12)
                .background(Color.clear)
        }
        .padding(12)
        .background(Color.black)
    }
}

extension GENBalanceChartView {
    
    private enum ChartRange: String, CaseIterable, Identifiable {
        case oneDay = "1D",
             fiveDays = "5D",
             oneMonth = "1M",
             threeMonths = "3M",
             sixMonths = "6M",
             oneYear = "1Y"
        
        var id: String { rawValue }
        
        var days: Int {
            switch self {
            case .oneDay: return 1
            case .fiveDays: return 5
            case .oneMonth: return 30
            case .threeMonths: return 90
            case .sixMonths: return 180
            case .oneYear: return 365
            }
        }
    }
    
    private func ChartView() -> some View {
        return Chart {
            
            // Plot the balance history as a line chart
            ForEach(balanceHistory, id: \.date) { point in
                LineMark(
                    x: .value(KEYS.date, point.date),
                    y: .value(KEYS.balance, point.balance)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.white)
                .lineStyle(StrokeStyle(lineWidth: 3))
            }
            
            // Highlight the selected point on chart
            if let selected = selectedSnapshot {
                PointMark(
                    x: .value(KEYS.date, selected.date),
                    y: .value(KEYS.balance, selected.balance)
                )
                .symbol {
                    Circle()
                        .strokeBorder(Color.red, lineWidth: 3)
                        .background(Circle().fill(Color.white))
                        .frame(width: 14, height: 14)
                }
            }
        }
        
        // Configure chart appearance
        // Hide X axis as it is replaced with Range segment
        .chartXAxis(.hidden)
        
        // Configure Y axis with custom styling
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisGridLine().foregroundStyle(Color.white.opacity(0.2))
                AxisTick().foregroundStyle(Color.white)
                AxisValueLabel().foregroundStyle(Color.white)
            }
        }
        .background(Color.black)
    }
    
    private func ChartOverlayView(_ proxy: ChartProxy) -> some View {
        return GeometryReader { geo in
            if let plotFrame = proxy.plotFrame {
                
                // Overlay for interaction on the chart
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let xPosition = value.location.x - geo[plotFrame].origin.x
                                if let date: Date = proxy.value(atX: xPosition) {
                                    if let nearest = balanceHistory.min(by: { abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) }) {
                                        
                                        // Update selected snapshot to nearest point
                                        selectedSnapshot = nearest
                                    }
                                }
                            }
                    )
                    .onTapGesture {
                        selectedSnapshot = nil
                    }
                
                // Display selected amount label if a point is selected
                if let selected = selectedSnapshot,
                   let posX = proxy.position(forX: selected.date),
                   let posY = proxy.position(forY: selected.balance) {
                    SelectedAmountLabel(amount: selected.balance, posX: posX, posY: posY)
                }
            }
        }
    }
    
    private func ChartRangeSegment() -> some View {
        return HStack(spacing: 0) {
            ForEach(ChartRange.allCases) { range in
                Button(action: {
                    selectedRange = range
                    selectedSnapshot = nil
                }) {
                    Text(range.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            selectedRange == range
                            ? Color.white.opacity(0.15)
                            : Color.clear
                        )
                        .cornerRadius(10)
                }
            }
        }
    }
}

// Label to display selected amount on chart
struct SelectedAmountLabel: View {
    let amount: Double
    let posX: CGFloat
    let posY: CGFloat
    
    private var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
    
    var body: some View {
        Text(formattedAmount)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.red)
            )
            .offset(x: 48, y: -24)
            .position(x: posX, y: posY)
    }
}

#Preview {
    // Example mock transactions for preview
    let now = Date()
    let transactions: [GENTransaction] = (0..<30).map { i in
        let isCredit = i % 5 == 0
        return GENTransaction(
            type: isCredit ? .credit : .debit,
            name: isCredit ? "Salary" : "Groceries",
            amount: isCredit ? 1000 : 50,
            timestamp: now.addingTimeInterval(-Double(29 - i) * 24 * 60 * 60)
        )
    }
    return GENBalanceChartView(transactions: transactions)
        .frame(height: 200)
        .padding()
        .background(Color.black)
}
