const InstanceStateChangeReasonCode = @import("instance_state_change_reason_code.zig").InstanceStateChangeReasonCode;

/// The details of the status change reason for the instance.
pub const InstanceStateChangeReason = struct {
    /// The programmable code for the state change reason.
    code: ?InstanceStateChangeReasonCode = null,

    /// The status change reason description.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
