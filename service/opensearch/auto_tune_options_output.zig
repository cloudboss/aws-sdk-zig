const AutoTuneState = @import("auto_tune_state.zig").AutoTuneState;

/// The Auto-Tune settings for a domain, displayed when enabling or disabling
/// Auto-Tune.
pub const AutoTuneOptionsOutput = struct {
    /// Any errors that occurred while enabling or disabling Auto-Tune.
    error_message: ?[]const u8,

    /// The current state of Auto-Tune on the domain.
    state: ?AutoTuneState,

    /// Whether the domain's off-peak window will be used to deploy Auto-Tune
    /// changes rather
    /// than a maintenance schedule.
    use_off_peak_window: ?bool,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .state = "State",
        .use_off_peak_window = "UseOffPeakWindow",
    };
};
