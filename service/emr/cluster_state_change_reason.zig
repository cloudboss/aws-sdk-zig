const ClusterStateChangeReasonCode = @import("cluster_state_change_reason_code.zig").ClusterStateChangeReasonCode;

/// The reason that the cluster changed to its current state.
pub const ClusterStateChangeReason = struct {
    /// The programmatic code for the state change reason.
    code: ?ClusterStateChangeReasonCode,

    /// The descriptive message for the state change reason.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
