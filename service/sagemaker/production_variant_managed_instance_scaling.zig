const ManagedInstanceScalingStatus = @import("managed_instance_scaling_status.zig").ManagedInstanceScalingStatus;

/// Settings that control the range in the number of instances that the endpoint
/// provisions as it scales up or down to accommodate traffic.
pub const ProductionVariantManagedInstanceScaling = struct {
    /// The maximum number of instances that the endpoint can provision when it
    /// scales up to accommodate an increase in traffic.
    max_instance_count: ?i32 = null,

    /// The minimum number of instances that the endpoint must retain when it scales
    /// down to accommodate a decrease in traffic.
    min_instance_count: ?i32 = null,

    /// Indicates whether managed instance scaling is enabled.
    status: ?ManagedInstanceScalingStatus = null,

    pub const json_field_names = .{
        .max_instance_count = "MaxInstanceCount",
        .min_instance_count = "MinInstanceCount",
        .status = "Status",
    };
};
