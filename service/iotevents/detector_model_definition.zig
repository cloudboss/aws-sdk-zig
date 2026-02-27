const State = @import("state.zig").State;

/// Information that defines how a detector operates.
pub const DetectorModelDefinition = struct {
    /// The state that is entered at the creation of each detector (instance).
    initial_state_name: []const u8,

    /// Information about the states of the detector.
    states: []const State,

    pub const json_field_names = .{
        .initial_state_name = "initialStateName",
        .states = "states",
    };
};
