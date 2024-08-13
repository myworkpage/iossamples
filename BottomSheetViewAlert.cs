using System;
using UIKit;

namespace PopUpSampleTest.BottomSheet
{
    public class BottomSheetViewAlert : UIView
    {
        private UIButton yesButton;
        private UIButton noButton;
        private UILabel messageLabel;
        private UIStackView buttonStackView;

        public BottomSheetViewAlert(string message)
        {
            BackgroundColor = UIColor.White;
            TranslatesAutoresizingMaskIntoConstraints = false;
            Layer.CornerRadius = 16;
            ClipsToBounds = true;

            // Create and configure the message label
            messageLabel = new UILabel
            {
                Text = message,
                TextAlignment = UITextAlignment.Center,
                Lines = 0,
                TranslatesAutoresizingMaskIntoConstraints = false
            };

            // Create and configure the "Yes" button
            yesButton = new UIButton(UIButtonType.System)
            {
                TranslatesAutoresizingMaskIntoConstraints = false
            };
            yesButton.SetTitle("Yes", UIControlState.Normal);
            yesButton.BackgroundColor = UIColor.FromRGB(0, 122, 255); // Blue color
            yesButton.SetTitleColor(UIColor.White, UIControlState.Normal); // White text color
            yesButton.Layer.CornerRadius = 8;
            yesButton.ClipsToBounds = true;

            // Create and configure the "No" button
            noButton = new UIButton(UIButtonType.System)
            {
                TranslatesAutoresizingMaskIntoConstraints = false
            };
            noButton.SetTitle("No", UIControlState.Normal);
            noButton.BackgroundColor = UIColor.FromRGB(0, 122, 255); // Blue color
            noButton.SetTitleColor(UIColor.White, UIControlState.Normal); // White text color
            noButton.Layer.CornerRadius = 8;
            noButton.ClipsToBounds = true;

            // Create a stack view to hold the buttons
            buttonStackView = new UIStackView(new UIView[] { yesButton, noButton })
            {
                Axis = UILayoutConstraintAxis.Horizontal,
                Distribution = UIStackViewDistribution.FillEqually,
                Spacing = 15,
                TranslatesAutoresizingMaskIntoConstraints = false
            };

            // Add subviews
            AddSubview(messageLabel);
            AddSubview(buttonStackView);

            // Set up constraints
            NSLayoutConstraint.ActivateConstraints(new NSLayoutConstraint[]
            {
            // Message label constraints
            messageLabel.TopAnchor.ConstraintEqualTo(TopAnchor, 20),
            messageLabel.LeftAnchor.ConstraintEqualTo(LeftAnchor, 20),
            messageLabel.RightAnchor.ConstraintEqualTo(RightAnchor, -20),

            // Button stack view constraints
            buttonStackView.TopAnchor.ConstraintEqualTo(messageLabel.BottomAnchor, 20),
            buttonStackView.LeftAnchor.ConstraintEqualTo(LeftAnchor, 20),
            buttonStackView.RightAnchor.ConstraintEqualTo(RightAnchor, -20),
            buttonStackView.BottomAnchor.ConstraintEqualTo(BottomAnchor, -20),
            buttonStackView.HeightAnchor.ConstraintEqualTo(50)
            });
        }

        public UIButton YesButton => yesButton;
        public UIButton NoButton => noButton;
    }
}
