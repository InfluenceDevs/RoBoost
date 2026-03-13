using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RoBoost.UI.ViewModels.Settings;

namespace RoBoost.UI.Elements.Settings.Pages
{
    /// <summary>
    /// Interaction logic for CoreSettingsPage.xaml
    /// </summary>
    public partial class CoreSettingsPage
    {
        public CoreSettingsPage()
        {
            DataContext = new CoreSettingsViewModel();
            InitializeComponent();
        }
    }
}

