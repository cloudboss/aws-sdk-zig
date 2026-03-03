const OffPeakWindow = @import("off_peak_window.zig").OffPeakWindow;

/// Options for a domain's [off-peak
/// window](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_OffPeakWindow.html), during which OpenSearch Service can perform mandatory configuration
/// changes on the domain.
pub const OffPeakWindowOptions = struct {
    /// Whether to enable an off-peak window.
    ///
    /// This option is only available when modifying a domain created prior to
    /// February 16,
    /// 2023, not when creating a new domain. All domains created after this date
    /// have the
    /// off-peak window enabled by default. You can't disable the off-peak window
    /// after it's
    /// enabled for a domain.
    enabled: ?bool = null,

    /// Off-peak window settings for the domain.
    off_peak_window: ?OffPeakWindow = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .off_peak_window = "OffPeakWindow",
    };
};
