const DefaultTargetCapacityType = @import("default_target_capacity_type.zig").DefaultTargetCapacityType;
const TargetCapacityUnitType = @import("target_capacity_unit_type.zig").TargetCapacityUnitType;

/// The number of units to request. You can choose to set the target capacity as
/// the number of
/// instances. Or you can set the target capacity to a performance
/// characteristic that is important to your application workload,
/// such as vCPUs, memory, or I/O. If the request type is `maintain`, you can
/// specify a target capacity of 0 and add capacity later.
///
/// You can use the On-Demand Instance `MaxTotalPrice` parameter, the Spot
/// Instance
/// `MaxTotalPrice` parameter, or both parameters to ensure that your fleet cost
/// does not exceed your budget. If you set a maximum price per hour for the
/// On-Demand Instances and Spot Instances
/// in your request, EC2 Fleet will launch instances until it reaches the
/// maximum amount that you're
/// willing to pay. When the maximum amount you're willing to pay is reached,
/// the fleet stops
/// launching instances even if it hasn't met the target capacity. The
/// `MaxTotalPrice` parameters are located in
/// [OnDemandOptionsRequest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_OnDemandOptionsRequest)
/// and
/// [SpotOptionsRequest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotOptionsRequest).
pub const TargetCapacitySpecificationRequest = struct {
    /// The default target capacity type.
    default_target_capacity_type: ?DefaultTargetCapacityType = null,

    /// The number of On-Demand units to request.
    on_demand_target_capacity: ?i32 = null,

    /// The number of Spot units to request.
    spot_target_capacity: ?i32 = null,

    /// The unit for the target capacity. You can specify this parameter only when
    /// using
    /// attributed-based instance type selection.
    ///
    /// Default: `units` (the number of instances)
    target_capacity_unit_type: ?TargetCapacityUnitType = null,

    /// The number of units to request, filled using the default target capacity
    /// type.
    total_target_capacity: i32,
};
