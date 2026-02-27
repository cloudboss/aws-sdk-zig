const OnDemandProvisioningAllocationStrategy = @import("on_demand_provisioning_allocation_strategy.zig").OnDemandProvisioningAllocationStrategy;
const OnDemandCapacityReservationOptions = @import("on_demand_capacity_reservation_options.zig").OnDemandCapacityReservationOptions;

/// The launch specification for On-Demand Instances in the instance fleet,
/// which
/// determines the allocation strategy.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions. On-Demand Instances allocation
/// strategy is
/// available in Amazon EMR releases 5.12.1 and later.
pub const OnDemandProvisioningSpecification = struct {
    /// Specifies the strategy to use in launching On-Demand instance fleets.
    /// Available
    /// options are `lowest-price` and `prioritized`. `lowest-price`
    /// specifies to launch the instances with the lowest price first, and
    /// `prioritized` specifies
    /// that Amazon EMR should launch the instances with the highest priority first.
    /// The default is
    /// `lowest-price`.
    allocation_strategy: OnDemandProvisioningAllocationStrategy,

    /// The launch specification for On-Demand instances in the instance fleet,
    /// which determines
    /// the allocation strategy.
    capacity_reservation_options: ?OnDemandCapacityReservationOptions,

    pub const json_field_names = .{
        .allocation_strategy = "AllocationStrategy",
        .capacity_reservation_options = "CapacityReservationOptions",
    };
};
