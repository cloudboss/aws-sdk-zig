const AutoTuneState = @import("auto_tune_state.zig").AutoTuneState;

/// Specifies the Auto-Tune options: the Auto-Tune desired state for the domain
/// and list of maintenance schedules.
pub const AutoTuneOptionsOutput = struct {
    /// Specifies the error message while enabling or disabling the Auto-Tune.
    error_message: ?[]const u8 = null,

    /// Specifies the `AutoTuneState` for the Elasticsearch domain.
    state: ?AutoTuneState = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .state = "State",
    };
};
