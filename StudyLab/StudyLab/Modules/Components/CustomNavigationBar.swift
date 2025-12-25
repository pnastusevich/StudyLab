import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    var leadingButton: (() -> AnyView)? = nil
    var trailingButton: (() -> AnyView)? = nil
    
    var body: some View {
        HStack {
            if let leading = leadingButton {
                leading()
            } else {
                Spacer()
                    .frame(width: 44)
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            if let trailing = trailingButton {
                trailing()
            } else {
                Spacer()
                    .frame(width: 44)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
    }
}

extension CustomNavigationBar {
    init(title: String) {
        self.title = title
        self.leadingButton = nil
        self.trailingButton = nil
    }
}

