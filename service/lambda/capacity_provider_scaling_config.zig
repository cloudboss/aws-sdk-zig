const CapacityProviderScalingMode = @import("capacity_provider_scaling_mode.zig").CapacityProviderScalingMode;
const TargetTrackingScalingPolicy = @import("target_tracking_scaling_policy.zig").TargetTrackingScalingPolicy;

/// Configuration that defines how the capacity provider scales compute
/// instances based on demand and policies.
pub const CapacityProviderScalingConfig = struct {
    /// The maximum number of vCPUs that the capacity provider can provision across
    /// all compute instances.
    max_v_cpu_count: ?i32 = null,

    /// The scaling mode that determines how the capacity provider responds to
    /// changes in demand.
    scaling_mode: ?CapacityProviderScalingMode = null,

    /// A list of scaling policies that define how the capacity provider scales
    /// compute instances based on metrics and thresholds.
    scaling_policies: ?[]const TargetTrackingScalingPolicy = null,

    pub const json_field_names = .{
        .max_v_cpu_count = "MaxVCpuCount",
        .scaling_mode = "ScalingMode",
        .scaling_policies = "ScalingPolicies",
    };
};
