const ScalingConstraints = @import("scaling_constraints.zig").ScalingConstraints;
const ScalingRule = @import("scaling_rule.zig").ScalingRule;
const AutoScalingPolicyStatus = @import("auto_scaling_policy_status.zig").AutoScalingPolicyStatus;

/// An automatic scaling policy for a core instance group or task instance group
/// in an
/// Amazon EMR cluster. The automatic scaling policy defines how an instance
/// group
/// dynamically adds and terminates Amazon EC2 instances in response to the
/// value of a
/// CloudWatch metric. See PutAutoScalingPolicy.
pub const AutoScalingPolicyDescription = struct {
    /// The upper and lower Amazon EC2 instance limits for an automatic scaling
    /// policy.
    /// Automatic scaling activity will not cause an instance group to grow above or
    /// below these
    /// limits.
    constraints: ?ScalingConstraints,

    /// The scale-in and scale-out rules that comprise the automatic scaling policy.
    rules: ?[]const ScalingRule,

    /// The status of an automatic scaling policy.
    status: ?AutoScalingPolicyStatus,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .rules = "Rules",
        .status = "Status",
    };
};
