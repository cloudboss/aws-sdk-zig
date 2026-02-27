const TargetTrackingScalingPolicyConfiguration = @import("target_tracking_scaling_policy_configuration.zig").TargetTrackingScalingPolicyConfiguration;

/// An object containing a recommended scaling policy.
pub const ScalingPolicy = union(enum) {
    /// A target tracking scaling policy. Includes support for predefined or
    /// customized metrics.
    target_tracking: ?TargetTrackingScalingPolicyConfiguration,

    pub const json_field_names = .{
        .target_tracking = "TargetTracking",
    };
};
