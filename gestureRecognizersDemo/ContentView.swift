//
//  ContentView.swift
//  gestureRecognizersDemo
//
//  Created by Itsuki on 2023/10/09.
//

import SwiftUI


struct ContentView : View {
    var body: some View {GestureCombinationDemo()}
}




struct DragGestureDemo: View {
    private let originalPosition = CGPoint(x: 150, y: 150)
    @State private var position = CGPoint(x: 150, y: 150)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.red)
            .position(position)
            .frame(width: 200 , height: 200)
            .gesture(DragGesture()
                .onChanged{ value in
                    position = value.location
                }
                .onEnded { _ in
                    position = originalPosition
                    
                }
                     
            )
    }
}




struct LongPressGestureDemo: View {
    
    @State private var scale = 1.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.red)
            .frame(width: 200 , height: 200)
            .scaleEffect(scale)
//            .onLongPressGesture(minimumDuration: 1, perform: {
//                scale = scale * 0.9
//            })
            .gesture(LongPressGesture(minimumDuration: 1)
                .onEnded{_ in scale = scale * 0.9})
        
    }
}


struct TapGestureDemo: View {
    
    @State private var scale = 1.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.red)
            .frame(width: 200 , height: 200)
            .scaleEffect(scale)
            .onTapGesture(count: 1, perform: {
                print("1 tap")
                scale = scale * 0.9
            })
            .highPriorityGesture(
                TapGesture(count: 2)
                    .onEnded{
                        print("2 tap")
                        scale = scale * 1.1
                    }
            )
        
    }
}




struct GestureCombinationDemo: View {
    @State private var shouldMove = false
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var scale = 1.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.red)
            .frame(width: 150 , height: 150)
            .position(position)
            .scaleEffect(scale)
            .gesture(
                LongPressGesture(minimumDuration: 0.7)
                    .onEnded { _ in
                        print("long press ended")
                        shouldMove = true
                        withAnimation{
                            scale = 1.1
                        }
                    }
                    .simultaneously(
                        with: DragGesture()
                            .onChanged { gesture in
                                if shouldMove {
                                    print("drag starts on ", gesture.location)
                                    position = gesture.location
                                } else {
                                    print("not able to move")
                                }
                            }
                            .onEnded { gesture in
                                print("drag endes")
                                shouldMove = false
                                withAnimation{
                                    scale = 1.0
                                }
                            }
                    )
            )

    }
    
    
}


#Preview {
    ContentView()
}
