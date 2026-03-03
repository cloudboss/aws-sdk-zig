const SpotCapacityRebalance = @import("spot_capacity_rebalance.zig").SpotCapacityRebalance;

/// The strategies for managing your Spot Instances that are at an elevated risk
/// of being
/// interrupted.
pub const SpotMaintenanceStrategies = struct {
    /// The Spot Instance replacement strategy to use when Amazon EC2 emits a signal
    /// that your
    /// Spot Instance is at an elevated risk of being interrupted. For more
    /// information, see
    /// [Capacity
    /// rebalancing](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-capacity-rebalance.html) in the *Amazon EC2 User Guide*.
    capacity_rebalance: ?SpotCapacityRebalance = null,
};
