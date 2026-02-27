const FleetScalingType = @import("fleet_scaling_type.zig").FleetScalingType;
const TargetTrackingScalingConfiguration = @import("target_tracking_scaling_configuration.zig").TargetTrackingScalingConfiguration;

/// The scaling configuration input of a compute fleet.
pub const ScalingConfigurationInput = struct {
    /// The maximum number of instances in the ﬂeet when auto-scaling.
    max_capacity: ?i32,

    /// The scaling type for a compute fleet.
    scaling_type: ?FleetScalingType,

    /// A list of `TargetTrackingScalingConfiguration` objects.
    target_tracking_scaling_configs: ?[]const TargetTrackingScalingConfiguration,

    pub const json_field_names = .{
        .max_capacity = "maxCapacity",
        .scaling_type = "scalingType",
        .target_tracking_scaling_configs = "targetTrackingScalingConfigs",
    };
};
