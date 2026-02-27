const ReplicationState = @import("replication_state.zig").ReplicationState;

/// Endpoints can replicate all events to the secondary Region.
pub const ReplicationConfig = struct {
    /// The state of event replication.
    state: ?ReplicationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
