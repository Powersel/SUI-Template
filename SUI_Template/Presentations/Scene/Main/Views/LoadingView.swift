import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack(spacing: 40) {
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
        .scaleEffect(2.0, anchor: .center)
      Text("We are loading recipes. Please wait").font(.largeTitle)
    }
  }
}

#Preview {
  LoadingView()
}
