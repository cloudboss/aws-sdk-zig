const AutoScalingPolicyState = @import("auto_scaling_policy_state.zig").AutoScalingPolicyState;
const AutoScalingPolicyStateChangeReason = @import("auto_scaling_policy_state_change_reason.zig").AutoScalingPolicyStateChangeReason;

/// The status of an automatic scaling policy.
pub const AutoScalingPolicyStatus = struct {
    /// Indicates the status of the automatic scaling policy.
    state: ?AutoScalingPolicyState,

    /// The reason for a change in status.
    state_change_reason: ?AutoScalingPolicyStateChangeReason,

    pub const json_field_names = .{
        .state = "State",
        .state_change_reason = "StateChangeReason",
    };
};
