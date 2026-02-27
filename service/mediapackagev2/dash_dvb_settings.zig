const DashDvbMetricsReporting = @import("dash_dvb_metrics_reporting.zig").DashDvbMetricsReporting;
const DashDvbFontDownload = @import("dash_dvb_font_download.zig").DashDvbFontDownload;

/// For endpoints that use the DVB-DASH profile only. The font download and
/// error reporting information that you want MediaPackage to pass through to
/// the manifest.
pub const DashDvbSettings = struct {
    /// Playback device error reporting settings.
    error_metrics: ?[]const DashDvbMetricsReporting,

    /// Subtitle font settings.
    font_download: ?DashDvbFontDownload,

    pub const json_field_names = .{
        .error_metrics = "ErrorMetrics",
        .font_download = "FontDownload",
    };
};
