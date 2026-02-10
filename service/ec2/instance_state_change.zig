const InstanceState = @import("instance_state.zig").InstanceState;

/// Describes an instance state change.
pub const InstanceStateChange = struct {
    /// The current state of the instance.
    current_state: ?InstanceState,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The previous state of the instance.
    previous_state: ?InstanceState,
};
