const ForwardingConfigState = @import("forwarding_config_state.zig").ForwardingConfigState;

/// The forwarding configuration for a given property.
pub const ForwardingConfig = struct {
    /// The forwarding state for the given property.
    state: ForwardingConfigState,

    pub const json_field_names = .{
        .state = "state",
    };
};
