const PolicyType = @import("policy_type.zig").PolicyType;
const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;

/// Represents a scaling policy.
pub const ScalingPolicy = struct {
    /// The name of the scaling policy.
    policy_name: []const u8,

    /// The type of scaling policy.
    policy_type: PolicyType,

    /// The target tracking scaling policy. Includes support for predefined or
    /// customized
    /// metrics.
    target_tracking_configuration: ?TargetTrackingConfiguration = null,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
        .policy_type = "PolicyType",
        .target_tracking_configuration = "TargetTrackingConfiguration",
    };
};
