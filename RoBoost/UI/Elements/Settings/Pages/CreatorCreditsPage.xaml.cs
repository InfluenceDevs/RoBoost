using System.Windows;

namespace RoBoost.UI.Elements.Settings.Pages
{
    /// <summary>
    /// Interaction logic for CreatorCreditsPage.xaml
    /// </summary>
    public partial class CreatorCreditsPage
    {
        public CreatorCreditsPage()
        {
            InitializeComponent();
        }

        private void OpenRepo_Click(object sender, RoutedEventArgs e)
        {
            Utilities.ShellExecute(App.ProjectDownloadLink);
        }

        private void OpenIssues_Click(object sender, RoutedEventArgs e)
        {
            Utilities.ShellExecute(App.ProjectSupportLink);
        }
    }
}
