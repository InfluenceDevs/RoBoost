using System.Windows;

namespace RoBoost.UI.Elements.Settings.Pages
{
    /// <summary>
    /// Interaction logic for PerformanceLabPage.xaml
    /// </summary>
    public partial class PerformanceLabPage
    {
        public PerformanceLabPage()
        {
            InitializeComponent();
        }

        private void OpenFastFlags_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(
                "Use the Fast Flags tab in the left navigation for advanced tuning.",
                "RoBoost Performance Lab",
                MessageBoxButton.OK,
                MessageBoxImage.Information
            );
        }
    }
}
