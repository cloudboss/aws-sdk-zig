const Timer = @import("timer.zig").Timer;
const Variable = @import("variable.zig").Variable;

/// Information about the current state of the detector instance.
pub const DetectorState = struct {
    /// The name of the state.
    state_name: []const u8,

    /// The current state of the detector's timers.
    timers: []const Timer,

    /// The current values of the detector's variables.
    variables: []const Variable,

    pub const json_field_names = .{
        .state_name = "stateName",
        .timers = "timers",
        .variables = "variables",
    };
};
