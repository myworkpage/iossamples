using CoreGraphics;
using Foundation;
using PopUpSampleTest.BottomSheet;
using System;
using UIKit;

namespace PopUpSampleTest
{
    public partial class ViewController : UIViewController
    {
        //UIButton buttonStarRect, buttonStarCustom, viewInWalletbutton;
        //UINavigationController navigationController { get; set; }
        //private BottomSheetView _bottomSheetView;

        public ViewController(IntPtr handle) : base(handle)
        {
        }

        public ViewController()
        {
        }

        //public override void ViewDidLoad()
        //{
        //    base.ViewDidLoad();
        //    // Add a button to show/hide the bottom sheet
        //    UIButton showButton = UIButton.FromType(UIButtonType.System);
        //    showButton.Frame = new CGRect(20, 80, 100, 50);
        //    showButton.SetTitle("Show", UIControlState.Normal);
        //    showButton.TouchUpInside += (sender, e) => _bottomSheetView.Show();
        //    UIButton hideButton = UIButton.FromType(UIButtonType.System);
        //    hideButton.Frame = new CGRect(20, 140, 100, 50);
        //    hideButton.SetTitle("Hide", UIControlState.Normal);
        //    hideButton.TouchUpInside += (sender, e) => _bottomSheetView.Hide();
        //    View.AddSubviews(showButton, hideButton);
        //    // Initialize bottom sheet
        //    _bottomSheetView = new BottomSheetView(150, View.Bounds.Height - 50, "Would you like to resubmit the survey?", BgColorChangeAction); // 300 is the height of the bottom sheet
        //    _bottomSheetView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin;
        //    // Add bottom sheet to the view controller’s view
        //    View.AddSubview(_bottomSheetView);
        //}

        //public override void ViewWillLayoutSubviews()
        //{
        //    base.ViewWillLayoutSubviews();
        //    _bottomSheetView.Frame = new CGRect(0, View.Bounds.Height - _bottomSheetView.Frame.Height, View.Bounds.Width, _bottomSheetView.Frame.Height);
        //}

        //void BgColorChangeAction(UIColor color)
        //{
        //    View.BackgroundColor = color;
        //}

        //private AnotherViewController _bottomSheetDialog;

        //public override void ViewDidLoad()
        //{
        //    base.ViewDidLoad();

        //    var showButton = new UIButton(UIButtonType.System)
        //    {
        //        Frame = new CGRect(20, 100, 280, 44),
        //        TitleLabel = { Text = "Show Bottom Sheet" },
        //        BackgroundColor = UIColor.Yellow,
        //        TintColor = UIColor.Black
        //    };
        //    showButton.TouchUpInside += ShowButton_TouchUpInside;

        //    View.BackgroundColor = UIColor.White;
        //    View.AddSubview(showButton);

        // Initialize BottomSheetDialog
        //_bottomSheetDialog = new AnotherViewController(View.Bounds)
        //{
        //    Frame = View.Bounds
        //};
        //_bottomSheetDialog.OnResult += (isYes) =>
        //{
        //    if (isYes)
        //    {
        //        ShowAlert("You pressed Yes!");
        //    }
        //    else
        //    {
        //        ShowAlert("You pressed No!");
        //    }
        //};

        //}

        //private UIAlertController _alertController;
        //private UIViewController _presentingController;

        //private void ShowButton_TouchUpInside(object sender, EventArgs e)
        //{
        // Check if bottom sheet is already shown
        //if (_bottomSheetDialog.Superview != null)
        //{
        //    _bottomSheetDialog.Hide();
        //}

        //View.AddSubview(_bottomSheetDialog);
        //_bottomSheetDialog.Show();


        //var controller = UIApplication.SharedApplication.KeyWindow.RootViewController;

        //// Create the alert controller
        //_alertController = UIAlertController.Create("", "Are you in?", UIAlertControllerStyle.ActionSheet);
        //_presentingController = controller;

        //// Add "Yes" button
        //_alertController.AddAction(UIAlertAction.Create("Yes", UIAlertActionStyle.Default, action => { DismissDialog(); }));

        //// Add "No" button
        //_alertController.AddAction(UIAlertAction.Create("No", UIAlertActionStyle.Cancel, action => { DismissDialog(); }));

        //// Present the alert controller
        //controller.PresentViewController(_alertController, true, null);

        // Assuming 'self' is your current UIViewController

        //}

        //void DismissDialog()
        //{
        //    if (_alertController != null && _presentingController != null)
        //    {
        //        _alertController.DismissViewController(true, null);
        //        _alertController = null;
        //        _presentingController = null;
        //    }
        //}

        //private void ShowAlert(string message)
        //{
        //    var alert = UIAlertController.Create("Result", message, UIAlertControllerStyle.Alert);
        //    alert.AddAction(UIAlertAction.Create("OK", UIAlertActionStyle.Default, null));
        //    PresentViewController(alert, true, null);
        //}


        private UIButton showBottomSheetButton;

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            // Create and configure the button to show the bottom sheet
            showBottomSheetButton = new UIButton(UIButtonType.System)
            {
                Frame = new CoreGraphics.CGRect(50, 50, 200, 50)
            };
            showBottomSheetButton.SetTitle("Show Bottom Sheet", UIControlState.Normal);
            showBottomSheetButton.TouchUpInside += ShowBottomSheetButton_TouchUpInside;

            View.AddSubview(showBottomSheetButton);
        }

        private void ShowBottomSheetButton_TouchUpInside(object sender, EventArgs e)
        {
            var bottomSheetViewController = new BottomSheetViewController("Are you sure you want to proceed?")
            {
                ModalPresentationStyle = UIModalPresentationStyle.OverFullScreen,
                ModalTransitionStyle = UIModalTransitionStyle.CoverVertical
            };

            PresentViewController(bottomSheetViewController, true, null);
        }
    }
}
