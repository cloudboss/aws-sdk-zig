const TimerDefinition = @import("timer_definition.zig").TimerDefinition;
const VariableDefinition = @import("variable_definition.zig").VariableDefinition;

/// The new state, variable values, and timer settings of the detector
/// (instance).
pub const DetectorStateDefinition = struct {
    /// The name of the new state of the detector (instance).
    state_name: []const u8,

    /// The new values of the detector's timers. Any timer whose value isn't
    /// specified is cleared,
    /// and its timeout event won't occur.
    timers: []const TimerDefinition,

    /// The new values of the detector's variables. Any variable whose value isn't
    /// specified is
    /// cleared.
    variables: []const VariableDefinition,

    pub const json_field_names = .{
        .state_name = "stateName",
        .timers = "timers",
        .variables = "variables",
    };
};
