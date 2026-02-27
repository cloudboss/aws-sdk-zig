const State = @import("state.zig").State;

/// Configuration to enable/disable processing of modality
pub const ModalityProcessingConfiguration = struct {
    state: ?State,

    pub const json_field_names = .{
        .state = "state",
    };
};
