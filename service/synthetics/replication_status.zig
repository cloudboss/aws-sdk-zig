const ReplicationState = @import("replication_state.zig").ReplicationState;

/// A structure that contains information about the replication status of a
/// canary replica.
pub const ReplicationStatus = struct {
    /// The replication state of the replica. Valid values are `InProgress`,
    /// `InSync`, and `Inconsistent`.
    state: ?ReplicationState = null,

    /// A description that provides more detail about the current replication state.
    state_reason: ?[]const u8 = null,

    /// A code that provides more detail about the current replication state.
    state_reason_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .state = "State",
        .state_reason = "StateReason",
        .state_reason_code = "StateReasonCode",
    };
};
