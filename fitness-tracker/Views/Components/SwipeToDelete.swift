//
//  SwipteToDelete.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-27.
//

import SwiftUI

struct SwipeToDelete<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var action: () -> ()

    let viewID = UUID()
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    self.content()
                        .containerRelativeFrame(.horizontal)
                        .background(.delete)
                        .id(viewID)
                    
                    DeleteButton {
                        withAnimation(.snappy(duration: 0.3)) {
                            scrollProxy.scrollTo(viewID)
                        }
                    }
                }
                .scrollTargetLayout()
                .visualEffect { content, geometryProxy in
                    content
                        .offset(x: scrollOffset(geometryProxy))
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .background(.delete)
            .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    @ViewBuilder
    func DeleteButton(event: @escaping() -> ()) -> some View {
        Rectangle()
            .frame(width: 100)
            .overlay {
                HStack {
                    Button {
                        Task {
                            event()
                            try? await Task.sleep(for: .seconds(0.4))
                            self.action()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 24, weight: .bold))
                            .tint(.white)
                            .frame(width: 100)
                            .frame(maxHeight: .infinity)
                    }
                    .background(.delete)
                }
            }
    }
    
    func scrollOffset(_ geometryProxy: GeometryProxy) -> CGFloat {
        let minX = geometryProxy.frame(in: .scrollView(axis: .horizontal)).minX
        
        return (minX > 0 ? -minX : 0)
    }
}
