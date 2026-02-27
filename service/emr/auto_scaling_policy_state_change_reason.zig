const AutoScalingPolicyStateChangeReasonCode = @import("auto_scaling_policy_state_change_reason_code.zig").AutoScalingPolicyStateChangeReasonCode;

/// The reason for an AutoScalingPolicyStatus change.
pub const AutoScalingPolicyStateChangeReason = struct {
    /// The code indicating the reason for the change in status.`USER_REQUEST`
    /// indicates that the scaling policy status was changed by a user.
    /// `PROVISION_FAILURE` indicates that the status change was because the policy
    /// failed to provision. `CLEANUP_FAILURE` indicates an error.
    code: ?AutoScalingPolicyStateChangeReasonCode,

    /// A friendly, more verbose message that accompanies an automatic scaling
    /// policy state
    /// change.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
