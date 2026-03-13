using System.IO;
using System.Text.Json;
using System.Windows;

namespace RoBoost.UI.Elements.Settings.Pages
{
    /// <summary>
    /// Interaction logic for SessionProfilesPage.xaml
    /// </summary>
    public partial class SessionProfilesPage
    {
        public SessionProfilesPage()
        {
            InitializeComponent();
        }

        private void ExportProfile_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var profile = new
                {
                    Name = "Balanced Daily",
                    ExportedAt = DateTime.UtcNow,
                    Owner = "Rloxx",
                    Source = "RoBoost"
                };

                string fileName = $"RoBoost-profile-{DateTime.Now:yyyyMMdd-HHmmss}.json";
                string path = Path.Combine(Paths.Desktop, fileName);

                File.WriteAllText(path, JsonSerializer.Serialize(profile, new JsonSerializerOptions { WriteIndented = true }));

                MessageBox.Show(
                    $"Profile exported to:\n{path}",
                    "RoBoost Session Profiles",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information
                );
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Failed to export profile: {ex.Message}",
                    "RoBoost Session Profiles",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning
                );
            }
        }
    }
}
