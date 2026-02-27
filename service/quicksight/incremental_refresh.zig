const LookbackWindow = @import("lookback_window.zig").LookbackWindow;

/// The incremental refresh configuration for a dataset.
pub const IncrementalRefresh = struct {
    /// The lookback window setup for an incremental refresh configuration.
    lookback_window: LookbackWindow,

    pub const json_field_names = .{
        .lookback_window = "LookbackWindow",
    };
};
