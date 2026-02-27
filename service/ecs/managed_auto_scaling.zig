const ManagedApplicationAutoScalingPolicy = @import("managed_application_auto_scaling_policy.zig").ManagedApplicationAutoScalingPolicy;
const ManagedScalableTarget = @import("managed_scalable_target.zig").ManagedScalableTarget;

/// The auto scaling configuration created by Amazon ECS for an Express service.
pub const ManagedAutoScaling = struct {
    /// The policy used for auto scaling.
    application_auto_scaling_policies: ?[]const ManagedApplicationAutoScalingPolicy,

    /// Represents a scalable target.
    scalable_target: ?ManagedScalableTarget,

    pub const json_field_names = .{
        .application_auto_scaling_policies = "applicationAutoScalingPolicies",
        .scalable_target = "scalableTarget",
    };
};
