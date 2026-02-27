const State = @import("state.zig").State;

/// Configures settings for the `SilentAudio` metric.
pub const SilentAudio = struct {
    /// Indicates whether the `SilentAudio` metric is enabled or disabled.
    state: ?State,

    /// Specifies the number of consecutive seconds of silence that triggers an
    /// event or alert.
    threshold_seconds: ?i32,

    pub const json_field_names = .{
        .state = "State",
        .threshold_seconds = "ThresholdSeconds",
    };
};
