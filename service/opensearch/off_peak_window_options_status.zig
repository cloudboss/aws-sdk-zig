const OffPeakWindowOptions = @import("off_peak_window_options.zig").OffPeakWindowOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of [off-peak
/// window](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_OffPeakWindow.html) options for a domain.
pub const OffPeakWindowOptionsStatus = struct {
    /// The domain's off-peak window configuration.
    options: ?OffPeakWindowOptions = null,

    /// The current status of off-peak window options.
    status: ?OptionStatus = null,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
