using System.IO;
using System.Windows;

namespace RoBoost.UI.Elements.Settings.Pages
{
    /// <summary>
    /// Interaction logic for QuickToolsPage.xaml
    /// </summary>
    public partial class QuickToolsPage
    {
        public QuickToolsPage()
        {
            InitializeComponent();
        }

        private static void OpenPath(string path)
        {
            if (string.IsNullOrWhiteSpace(path))
                return;

            Directory.CreateDirectory(path);
            Utilities.ShellExecute(path);
        }

        private void OpenInstallFolder_Click(object sender, RoutedEventArgs e)
        {
            OpenPath(Paths.Base);
        }

        private void OpenLogsFolder_Click(object sender, RoutedEventArgs e)
        {
            OpenPath(Paths.Logs);
        }

        private void OpenModsFolder_Click(object sender, RoutedEventArgs e)
        {
            OpenPath(Paths.Modifications);
        }

        private void ClearCache_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (Directory.Exists(Paths.Temp))
                    Directory.Delete(Paths.Temp, true);

                Directory.CreateDirectory(Paths.Temp);

                MessageBox.Show(
                    "Temporary cache was cleared successfully.",
                    "RoBoost Quick Tools",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information
                );
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Failed to clear cache: {ex.Message}",
                    "RoBoost Quick Tools",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning
                );
            }
        }

        private void BackupSettings_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string source = App.Settings.FileLocation;

                if (!File.Exists(source))
                {
                    MessageBox.Show(
                        "No settings file was found to back up yet.",
                        "RoBoost Quick Tools",
                        MessageBoxButton.OK,
                        MessageBoxImage.Information
                    );
                    return;
                }

                string fileName = $"RoBoost-settings-backup-{DateTime.Now:yyyyMMdd-HHmmss}.json";
                string destination = Path.Combine(Paths.Desktop, fileName);

                File.Copy(source, destination, true);

                MessageBox.Show(
                    $"Settings backup created at:\n{destination}",
                    "RoBoost Quick Tools",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information
                );
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Failed to back up settings: {ex.Message}",
                    "RoBoost Quick Tools",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning
                );
            }
        }
    }
}
