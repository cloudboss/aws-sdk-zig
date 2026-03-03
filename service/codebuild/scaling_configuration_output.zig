const FleetScalingType = @import("fleet_scaling_type.zig").FleetScalingType;
const TargetTrackingScalingConfiguration = @import("target_tracking_scaling_configuration.zig").TargetTrackingScalingConfiguration;

/// The scaling configuration output of a compute fleet.
pub const ScalingConfigurationOutput = struct {
    /// The desired number of instances in the ﬂeet when auto-scaling.
    desired_capacity: ?i32 = null,

    /// The maximum number of instances in the ﬂeet when auto-scaling.
    max_capacity: ?i32 = null,

    /// The scaling type for a compute fleet.
    scaling_type: ?FleetScalingType = null,

    /// A list of `TargetTrackingScalingConfiguration` objects.
    target_tracking_scaling_configs: ?[]const TargetTrackingScalingConfiguration = null,

    pub const json_field_names = .{
        .desired_capacity = "desiredCapacity",
        .max_capacity = "maxCapacity",
        .scaling_type = "scalingType",
        .target_tracking_scaling_configs = "targetTrackingScalingConfigs",
    };
};
