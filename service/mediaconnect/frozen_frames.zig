const State = @import("state.zig").State;

/// Configures settings for the `FrozenFrames` metric.
pub const FrozenFrames = struct {
    /// Indicates whether the `FrozenFrames` metric is enabled or disabled.
    state: ?State = null,

    /// Specifies the number of consecutive seconds of a static image that triggers
    /// an event or alert.
    threshold_seconds: ?i32 = null,

    pub const json_field_names = .{
        .state = "State",
        .threshold_seconds = "ThresholdSeconds",
    };
};
