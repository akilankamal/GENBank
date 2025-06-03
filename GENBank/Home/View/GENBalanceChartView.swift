//
//  GENBalanceChartView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI
import Charts

enum ChartRange: String, CaseIterable, Identifiable {
    case oneDay = "1D", fiveDays = "5D", oneMonth = "1M", threeMonths = "3M", sixMonths = "6M", oneYear = "1Y"
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

struct GENBalanceChartView: View {
    let transactions: [GENTransaction]
    @State private var selectedRange: ChartRange = .oneMonth
    @State private var selectedSnapshot: (date: Date, balance: Double)?

    private var balanceHistory: [(date: Date, balance: Double)] {
        var history: [(Date, Double)] = []
        var running = 0.0
        let sorted = transactions.sorted { $0.timestamp < $1.timestamp }
        for tx in sorted {
            running += (tx.type == .credit ? tx.amount : -tx.amount)
            history.append((tx.timestamp, running))
        }
        let cutoff = Calendar.current.date(byAdding: .day, value: -selectedRange.days, to: Date()) ?? Date()
        return history.filter { $0.0 >= cutoff }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Chart {
                ForEach(balanceHistory, id: \.date) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("Balance", point.balance)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.white)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                }
                if let selected = selectedSnapshot {
                    PointMark(
                        x: .value("Date", selected.date),
                        y: .value("Balance", selected.balance)
                    )
                    .symbol {
                        Circle()
                            .strokeBorder(Color.red, lineWidth: 3)
                            .background(Circle().fill(Color.white))
                            .frame(width: 14, height: 14)
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine().foregroundStyle(Color.white.opacity(0.2))
                    AxisTick().foregroundStyle(Color.white)
                    AxisValueLabel().foregroundStyle(Color.white)
                }
            }
            .background(Color.black)
            .chartOverlay { proxy in
                GeometryReader { geo in
                    if let plotFrame = proxy.plotFrame {
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        let xPosition = value.location.x - geo[plotFrame].origin.x
                                        if let date: Date = proxy.value(atX: xPosition) {
                                            if let nearest = balanceHistory.min(by: { abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) }) {
                                                selectedSnapshot = nearest
                                            }
                                        }
                                    }
                            )
                            .onTapGesture {
                                selectedSnapshot = nil
                            }
                        if let selected = selectedSnapshot,
                           let posX = proxy.position(forX: selected.date),
                           let posY = proxy.position(forY: selected.balance) {
                            SelectedAmountLabel(amount: selected.balance, posX: posX, posY: posY)
                        }
                    }
                }
            }
            
            // Picker at the bottom
            HStack(spacing: 0) {
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
            .background(Color.clear)
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .padding(12)
        .background(Color.black)
    }
}

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
