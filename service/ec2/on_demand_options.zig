const FleetOnDemandAllocationStrategy = @import("fleet_on_demand_allocation_strategy.zig").FleetOnDemandAllocationStrategy;
const CapacityReservationOptions = @import("capacity_reservation_options.zig").CapacityReservationOptions;

/// Describes the configuration of On-Demand Instances in an EC2 Fleet.
pub const OnDemandOptions = struct {
    /// The strategy that determines the order of the launch template overrides to
    /// use in
    /// fulfilling On-Demand capacity.
    ///
    /// `lowest-price` - EC2 Fleet uses price to determine the order, launching the
    /// lowest
    /// price first.
    ///
    /// `prioritized` - EC2 Fleet uses the priority that you assigned to each launch
    /// template override, launching the highest priority first.
    ///
    /// Default: `lowest-price`
    allocation_strategy: ?FleetOnDemandAllocationStrategy = null,

    /// The strategy for using unused Capacity Reservations for fulfilling On-Demand
    /// capacity.
    ///
    /// Supported only for fleets of type `instant`.
    capacity_reservation_options: ?CapacityReservationOptions = null,

    /// The maximum amount per hour for On-Demand Instances that you're willing to
    /// pay.
    ///
    /// If your fleet includes T instances that are configured as `unlimited`, and
    /// if their average CPU usage exceeds the baseline utilization, you will incur
    /// a charge for
    /// surplus credits. The `maxTotalPrice` does not account for surplus credits,
    /// and, if you use surplus credits, your final cost might be higher than what
    /// you specified
    /// for `maxTotalPrice`. For more information, see [Surplus credits can incur
    /// charges](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode-concepts.html#unlimited-mode-surplus-credits) in the
    /// *Amazon EC2 User Guide*.
    max_total_price: ?[]const u8 = null,

    /// The minimum target capacity for On-Demand Instances in the fleet. If this
    /// minimum capacity isn't
    /// reached, no instances are launched.
    ///
    /// Constraints: Maximum value of `1000`. Supported only for fleets of type
    /// `instant`.
    ///
    /// At least one of the following must be specified: `SingleAvailabilityZone` |
    /// `SingleInstanceType`
    min_target_capacity: ?i32 = null,

    /// Indicates that the fleet launches all On-Demand Instances into a single
    /// Availability Zone.
    ///
    /// Supported only for fleets of type `instant`.
    single_availability_zone: ?bool = null,

    /// Indicates that the fleet uses a single instance type to launch all On-Demand
    /// Instances in the
    /// fleet.
    ///
    /// Supported only for fleets of type `instant`.
    single_instance_type: ?bool = null,
};
