using System.Windows;
using System.Windows.Input;

using CommunityToolkit.Mvvm.Input;

using RoBoost.Enums.FlagPresets;

namespace RoBoost.UI.ViewModels.Settings
{
    public class FastFlagsViewModel : NotifyPropertyChangedViewModel
    {
        private const string FpsCapFlag = "DFIntTaskSchedulerTargetFps";
        private const string TextureSkipMipsFlag = "DebugTextureManagerSkipMips";
        private const string TextureManagerFlag = "RenderUseTextureManager224";

        private Dictionary<string, object>? _preResetFlags;
        private uint _customFpsCap = 240;

        public event EventHandler? RequestPageReloadEvent;

        public event EventHandler? OpenFlagEditorEvent;

        public FastFlagsViewModel()
        {
            if (UInt32.TryParse(App.FastFlags.GetValue(FpsCapFlag), out uint fpsCap) && fpsCap > 0)
                _customFpsCap = fpsCap;
        }

        private void OpenFastFlagEditor() => OpenFlagEditorEvent?.Invoke(this, EventArgs.Empty);

        public ICommand OpenFastFlagEditorCommand => new RelayCommand(OpenFastFlagEditor);
        public ICommand ApplyHighFpsPresetCommand => new RelayCommand(ApplyHighFpsPreset);
        public ICommand ApplyLowPingPresetCommand => new RelayCommand(ApplyLowPingPreset);
        public ICommand ApplyBalancedPresetCommand => new RelayCommand(ApplyBalancedPreset);

        public Visibility CanShowFastFlagEditor => Visibility.Visible;

        public bool UseFastFlagManager
        {
            get => App.Settings.Prop.UseFastFlagManager;
            set => App.Settings.Prop.UseFastFlagManager = value;
        }

        public IReadOnlyDictionary<MSAAMode, string?> MSAALevels => FastFlagManager.MSAAModes;

        public MSAAMode SelectedMSAALevel
        {
            get => MSAALevels.FirstOrDefault(x => x.Value == App.FastFlags.GetPreset("Rendering.MSAA")).Key;
            set => App.FastFlags.SetPreset("Rendering.MSAA", MSAALevels[value]);
        }

        public IReadOnlyDictionary<RenderingMode, string> RenderingModes => FastFlagManager.RenderingModes;

        public RenderingMode SelectedRenderingMode
        {
            get => App.FastFlags.GetPresetEnum(RenderingModes, "Rendering.Mode", "True");
            set => App.FastFlags.SetPresetEnum("Rendering.Mode", RenderingModes[value], "True");
        }

        public bool FixDisplayScaling
        {
            get => App.FastFlags.GetPreset("Rendering.DisableScaling") == "True";
            set => App.FastFlags.SetPreset("Rendering.DisableScaling", value ? "True" : null);
        }

        public bool FpsCapEnabled
        {
            get => App.FastFlags.GetValue(FpsCapFlag) is not null;
            set
            {
                if (value)
                    App.FastFlags.SetValue(FpsCapFlag, _customFpsCap.ToString());
                else
                    App.FastFlags.SetValue(FpsCapFlag, null);
            }
        }

        public uint CustomFpsCap
        {
            get => _customFpsCap;
            set
            {
                _customFpsCap = value == 0 ? 1U : value;

                if (FpsCapEnabled)
                    App.FastFlags.SetValue(FpsCapFlag, _customFpsCap.ToString());
            }
        }

        public IReadOnlyDictionary<TextureQuality, string?> TextureQualities => FastFlagManager.TextureQualityLevels;

        public TextureQuality SelectedTextureQuality
        {
            get => TextureQualities.Where(x => x.Value == App.FastFlags.GetPreset("Rendering.TextureQuality.Level")).FirstOrDefault().Key;
            set
            {
                if (value == TextureQuality.Default)
                {
                    App.FastFlags.SetPreset("Rendering.TextureQuality", null);
                }
                else
                {
                    App.FastFlags.SetPreset("Rendering.TextureQuality.OverrideEnabled", "True");
                    App.FastFlags.SetPreset("Rendering.TextureQuality.Level", TextureQualities[value]);
                }
            }
        }
        public bool ResetConfiguration
        {
            get => _preResetFlags is not null;

            set
            {
                if (value)
                {
                    _preResetFlags = new(App.FastFlags.Prop);
                    App.FastFlags.Prop.Clear();
                }
                else
                {
                    App.FastFlags.Prop = _preResetFlags!;
                    _preResetFlags = null;
                }

                RequestPageReloadEvent?.Invoke(this, EventArgs.Empty);
            }
        }

        public IReadOnlyDictionary<int, string> TextureRemovalMethods => new Dictionary<int, string>
        {
            { 1, "Method 1 (removing from file)" },
            { 2, "Method 2 (FFlag)" }
        };

        public int SelectedTextureRemovalMethod
        {
            get => App.Settings.Prop.TextureRemovalMethod is 2 ? 2 : 1;
            set
            {
                App.Settings.Prop.TextureRemovalMethod = value is 2 ? 2 : 1;

                if (RemoveTexturesEnabled)
                    ApplyTextureRemovalMethod();
            }
        }

        public bool RemoveTexturesEnabled
        {
            get =>
                App.Settings.Prop.UseDisableAppPatch ||
                App.FastFlags.GetValue(TextureSkipMipsFlag) is not null ||
                App.FastFlags.GetValue(TextureManagerFlag) is not null;
            set
            {
                if (value)
                {
                    ApplyTextureRemovalMethod();
                }
                else
                {
                    App.Settings.Prop.UseDisableAppPatch = false;
                    App.FastFlags.SetValue(TextureSkipMipsFlag, null);
                    App.FastFlags.SetValue(TextureManagerFlag, null);
                }
            }
        }

        private void ApplyTextureRemovalMethod()
        {
            if (SelectedTextureRemovalMethod == 1)
            {
                App.Settings.Prop.UseDisableAppPatch = true;
                App.FastFlags.SetValue(TextureSkipMipsFlag, null);
                App.FastFlags.SetValue(TextureManagerFlag, null);
                return;
            }

            App.Settings.Prop.UseDisableAppPatch = false;
            App.FastFlags.SetValue(TextureSkipMipsFlag, "8");
            App.FastFlags.SetValue(TextureManagerFlag, "False");
        }

        private void ApplyHighFpsPreset()
        {
            SelectedRenderingMode = RenderingMode.D3D11;
            SelectedMSAALevel = MSAAMode.x1;
            SelectedTextureQuality = TextureQuality.Level0;
            FixDisplayScaling = true;
            RemoveTexturesEnabled = false;
            CustomFpsCap = 240;
            FpsCapEnabled = true;
            RequestPageReloadEvent?.Invoke(this, EventArgs.Empty);
        }

        private void ApplyLowPingPreset()
        {
            SelectedRenderingMode = RenderingMode.D3D10;
            SelectedMSAALevel = MSAAMode.x1;
            SelectedTextureQuality = TextureQuality.Level0;
            FixDisplayScaling = true;
            SelectedTextureRemovalMethod = 2;
            RemoveTexturesEnabled = true;
            FpsCapEnabled = false;
            RequestPageReloadEvent?.Invoke(this, EventArgs.Empty);
        }

        private void ApplyBalancedPreset()
        {
            SelectedRenderingMode = RenderingMode.D3D11;
            SelectedMSAALevel = MSAAMode.x2;
            SelectedTextureQuality = TextureQuality.Level2;
            FixDisplayScaling = true;
            RemoveTexturesEnabled = false;
            FpsCapEnabled = false;
            RequestPageReloadEvent?.Invoke(this, EventArgs.Empty);
        }
    }
}

