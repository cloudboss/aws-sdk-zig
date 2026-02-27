const SpotProvisioningAllocationStrategy = @import("spot_provisioning_allocation_strategy.zig").SpotProvisioningAllocationStrategy;

/// The resize specification for Spot Instances in the instance fleet, which
/// contains the
/// resize timeout period.
pub const SpotResizingSpecification = struct {
    /// Specifies the allocation strategy to use to launch Spot instances during a
    /// resize. If you run Amazon EMR releases 6.9.0 or higher,
    /// the default is `price-capacity-optimized`. If you run Amazon EMR releases
    /// 6.8.0 or lower, the default is
    /// `capacity-optimized`.
    allocation_strategy: ?SpotProvisioningAllocationStrategy,

    /// Spot resize timeout in minutes. If Spot Instances are not provisioned within
    /// this time,
    /// the resize workflow will stop provisioning of Spot instances. Minimum value
    /// is 5 minutes
    /// and maximum value is 10,080 minutes (7 days). The timeout applies to all
    /// resize workflows
    /// on the Instance Fleet. The resize could be triggered by Amazon EMR Managed
    /// Scaling
    /// or by the customer (via Amazon EMR Console, Amazon EMR CLI
    /// modify-instance-fleet or Amazon EMR SDK ModifyInstanceFleet API) or by
    /// Amazon EMR due to Amazon EC2 Spot Reclamation.
    timeout_duration_minutes: ?i32,

    pub const json_field_names = .{
        .allocation_strategy = "AllocationStrategy",
        .timeout_duration_minutes = "TimeoutDurationMinutes",
    };
};
