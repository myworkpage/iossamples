using System;
using UIKit;

namespace PopUpSampleTest.BottomSheet
{
    public class BottomSheetViewController : UIViewController
    {
        private readonly string message;
        private BottomSheetViewAlert bottomSheetView;
        private DimmingView dimmingView;

        public BottomSheetViewController(string message)
        {
            this.message = message;
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            // Initialize and configure the bottom sheet view
            bottomSheetView = new BottomSheetViewAlert(message);
            bottomSheetView.TranslatesAutoresizingMaskIntoConstraints = false;
            View.AddSubview(bottomSheetView);

            // Initialize and configure the dimming view
            dimmingView = new DimmingView();
            dimmingView.TranslatesAutoresizingMaskIntoConstraints = false;
            View.InsertSubviewBelow(dimmingView, bottomSheetView);

            // Set up constraints for bottomSheetView
            NSLayoutConstraint.ActivateConstraints(new NSLayoutConstraint[]
            {
            bottomSheetView.LeftAnchor.ConstraintEqualTo(View.LeftAnchor),
            bottomSheetView.RightAnchor.ConstraintEqualTo(View.RightAnchor),
            bottomSheetView.BottomAnchor.ConstraintEqualTo(View.BottomAnchor),
            bottomSheetView.HeightAnchor.ConstraintEqualTo(200)
            });

            // Set up constraints for dimmingView
            NSLayoutConstraint.ActivateConstraints(new NSLayoutConstraint[]
            {
            dimmingView.LeftAnchor.ConstraintEqualTo(View.LeftAnchor),
            dimmingView.RightAnchor.ConstraintEqualTo(View.RightAnchor),
            dimmingView.TopAnchor.ConstraintEqualTo(View.TopAnchor),
            dimmingView.BottomAnchor.ConstraintEqualTo(View.BottomAnchor)
            });

            // Handle button actions
            bottomSheetView.YesButton.TouchUpInside += (sender, e) =>
            {
                // Handle "Yes" button action
                Console.WriteLine("User selected Yes");
                DismissViewController(true, null);
            };

            bottomSheetView.NoButton.TouchUpInside += (sender, e) =>
            {
                // Handle "No" button action
                Console.WriteLine("User selected No");
                DismissViewController(true, null);
            };
        }
    }
}
