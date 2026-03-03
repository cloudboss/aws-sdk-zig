const DefaultTargetCapacityType = @import("default_target_capacity_type.zig").DefaultTargetCapacityType;
const TargetCapacityUnitType = @import("target_capacity_unit_type.zig").TargetCapacityUnitType;

/// The number of units to request. You can choose to set the target capacity in
/// terms of
/// instances or a performance characteristic that is important to your
/// application workload,
/// such as vCPUs, memory, or I/O. If the request type is `maintain`, you can
/// specify a target capacity of 0 and add capacity later.
///
/// You can use the On-Demand Instance `MaxTotalPrice` parameter, the Spot
/// Instance
/// `MaxTotalPrice`, or both to ensure that your fleet cost does not exceed your
/// budget. If you set a maximum price per hour for the On-Demand Instances and
/// Spot Instances in your request, EC2 Fleet
/// will launch instances until it reaches the maximum amount that you're
/// willing to pay. When
/// the maximum amount you're willing to pay is reached, the fleet stops
/// launching instances
/// even if it hasn’t met the target capacity. The `MaxTotalPrice` parameters
/// are
/// located in
/// [OnDemandOptions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_OnDemandOptions.html)
/// and
/// [SpotOptions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotOptions).
pub const TargetCapacitySpecification = struct {
    /// The default target capacity type.
    default_target_capacity_type: ?DefaultTargetCapacityType = null,

    /// The number of On-Demand units to request. If you specify a target capacity
    /// for Spot units, you cannot specify a target capacity for On-Demand units.
    on_demand_target_capacity: ?i32 = null,

    /// The maximum number of Spot units to launch. If you specify a target capacity
    /// for On-Demand units, you cannot specify a target capacity for Spot units.
    spot_target_capacity: ?i32 = null,

    /// The unit for the target capacity.
    target_capacity_unit_type: ?TargetCapacityUnitType = null,

    /// The number of units to request, filled the default target capacity type.
    total_target_capacity: ?i32 = null,
};
