const OnDemandProvisioningAllocationStrategy = @import("on_demand_provisioning_allocation_strategy.zig").OnDemandProvisioningAllocationStrategy;
const OnDemandCapacityReservationOptions = @import("on_demand_capacity_reservation_options.zig").OnDemandCapacityReservationOptions;

/// The resize specification for On-Demand Instances in the instance fleet,
/// which contains
/// the resize timeout period.
pub const OnDemandResizingSpecification = struct {
    /// Specifies the allocation strategy to use to launch On-Demand instances
    /// during a resize. The default is `lowest-price`.
    allocation_strategy: ?OnDemandProvisioningAllocationStrategy,

    capacity_reservation_options: ?OnDemandCapacityReservationOptions,

    /// On-Demand resize timeout in minutes. If On-Demand Instances are not
    /// provisioned within
    /// this time, the resize workflow stops. The minimum value is 5 minutes, and
    /// the maximum value
    /// is 10,080 minutes (7 days). The timeout applies to all resize workflows on
    /// the Instance
    /// Fleet. The resize could be triggered by Amazon EMR Managed Scaling or by the
    /// customer (via Amazon EMR Console, Amazon EMR CLI modify-instance-fleet or
    /// Amazon EMR SDK ModifyInstanceFleet API) or by Amazon EMR due to Amazon EC2
    /// Spot Reclamation.
    timeout_duration_minutes: ?i32,

    pub const json_field_names = .{
        .allocation_strategy = "AllocationStrategy",
        .capacity_reservation_options = "CapacityReservationOptions",
        .timeout_duration_minutes = "TimeoutDurationMinutes",
    };
};
