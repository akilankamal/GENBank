//
//  RecipientsSection.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct RecipientsSection: View {
    let recipients: [GENRecipient]
    let avatarSize: CGFloat = 56
    let spacing: CGFloat = 16

    @State private var showAll: Bool = false
    @State private var initialVisible: Int = 5

    func recipientImage(_ picture: String) -> Image {
        if UIImage(named: picture) != nil {
            return Image(picture)
        } else {
            return Image(systemName: picture)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recipients")
                .font(.headline)
                .padding(.bottom, 4)

            GeometryReader { geometry in
                let width = geometry.size.width
                let maxVisible = max(1, Int((width + spacing) / (avatarSize + spacing)))
                let visibleCount = showAll ? recipients.count : min(maxVisible, recipients.count)
                let shouldShowMask = !showAll && recipients.count > visibleCount
                let lastIndex = visibleCount - 1

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(Array(recipients.prefix(visibleCount).enumerated()), id: \.element.name) { idx, recipient in
                            ZStack(alignment: .bottomTrailing) {
                                ZStack {
                                    recipientImage(recipient.picture)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: avatarSize, height: avatarSize)
                                        .clipShape(Circle())
                                        .background(Circle().fill(Color.gray.opacity(0.1)))
                                    if shouldShowMask && idx == lastIndex {
                                        Button(action: {
                                            withAnimation { showAll = true }
                                        }) {
                                            ZStack {
                                                Color.black.opacity(0.55)
                                                    .clipShape(Circle())
                                                Text("+\(recipients.count - visibleCount)")
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                            }
                                        }
                                        .frame(width: avatarSize, height: avatarSize)
                                    }
                                }
                                Circle()
                                    .fill(recipient.isOnline ? Color.green : Color.orange)
                                    .frame(width: 12, height: 12)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
                .onAppear {
                    initialVisible = maxVisible
                }
            }
            .frame(height: avatarSize + 24)
        }
    }
}

struct RecipientsSection_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRecipients = [
            GENRecipient(name: "Alice", picture: "mock_dp1", isOnline: true),
            GENRecipient(name: "Bob", picture: "mock_dp2", isOnline: false),
            GENRecipient(name: "Charlie", picture: "mock_dp3", isOnline: true),
            GENRecipient(name: "Diana", picture: "mock_dp1", isOnline: false),
            GENRecipient(name: "Eve", picture: "mock_dp1", isOnline: true),
            GENRecipient(name: "Frank", picture: "mock_dp3", isOnline: false),
            GENRecipient(name: "Grace", picture: "mock_dp2", isOnline: true),
            GENRecipient(name: "Heidi", picture: "mock_dp1", isOnline: false)
        ]
        RecipientsSection(recipients: sampleRecipients)
            .background(Color(.systemBackground))
            .previewLayout(.sizeThatFits)
    }
}
