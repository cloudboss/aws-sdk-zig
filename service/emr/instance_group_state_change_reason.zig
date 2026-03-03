const InstanceGroupStateChangeReasonCode = @import("instance_group_state_change_reason_code.zig").InstanceGroupStateChangeReasonCode;

/// The status change reason details for the instance group.
pub const InstanceGroupStateChangeReason = struct {
    /// The programmable code for the state change reason.
    code: ?InstanceGroupStateChangeReasonCode = null,

    /// The status change reason description.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
