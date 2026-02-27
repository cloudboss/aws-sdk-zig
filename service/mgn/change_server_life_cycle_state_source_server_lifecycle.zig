const ChangeServerLifeCycleStateSourceServerLifecycleState = @import("change_server_life_cycle_state_source_server_lifecycle_state.zig").ChangeServerLifeCycleStateSourceServerLifecycleState;

/// The request to change the source server migration lifecycle state.
pub const ChangeServerLifeCycleStateSourceServerLifecycle = struct {
    /// The request to change the source server migration lifecycle state.
    state: ChangeServerLifeCycleStateSourceServerLifecycleState,

    pub const json_field_names = .{
        .state = "state",
    };
};
