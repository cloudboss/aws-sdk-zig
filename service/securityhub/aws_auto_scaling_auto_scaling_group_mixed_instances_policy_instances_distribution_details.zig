/// Information about the instances distribution.
pub const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyInstancesDistributionDetails = struct {
    /// How to allocate instance types to fulfill On-Demand capacity. The valid
    /// value is `prioritized`.
    on_demand_allocation_strategy: ?[]const u8 = null,

    /// The minimum amount of the Auto Scaling group's capacity that must be
    /// fulfilled by On-Demand Instances.
    on_demand_base_capacity: ?i32 = null,

    /// The percentage of On-Demand Instances and Spot Instances for additional
    /// capacity beyond `OnDemandBaseCapacity`.
    on_demand_percentage_above_base_capacity: ?i32 = null,

    /// How to allocate instances across Spot Instance pools. Valid values are as
    /// follows:
    ///
    /// * `lowest-price`
    ///
    /// * `capacity-optimized`
    ///
    /// * `capacity-optimized-prioritized`
    spot_allocation_strategy: ?[]const u8 = null,

    /// The number of Spot Instance pools across which to allocate your Spot
    /// Instances.
    spot_instance_pools: ?i32 = null,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance.
    spot_max_price: ?[]const u8 = null,

    pub const json_field_names = .{
        .on_demand_allocation_strategy = "OnDemandAllocationStrategy",
        .on_demand_base_capacity = "OnDemandBaseCapacity",
        .on_demand_percentage_above_base_capacity = "OnDemandPercentageAboveBaseCapacity",
        .spot_allocation_strategy = "SpotAllocationStrategy",
        .spot_instance_pools = "SpotInstancePools",
        .spot_max_price = "SpotMaxPrice",
    };
};
