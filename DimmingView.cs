using System;
using UIKit;

namespace PopUpSampleTest.BottomSheet
{
    public class DimmingView : UIView
    {
        public DimmingView()
        {
            BackgroundColor = UIColor.Black.ColorWithAlpha(0.5f); // Semi-transparent black
            TranslatesAutoresizingMaskIntoConstraints = false;
        }
    }
}
