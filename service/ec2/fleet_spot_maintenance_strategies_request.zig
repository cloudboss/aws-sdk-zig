const FleetSpotCapacityRebalanceRequest = @import("fleet_spot_capacity_rebalance_request.zig").FleetSpotCapacityRebalanceRequest;

/// The strategies for managing your Spot Instances that are at an elevated risk
/// of being interrupted.
pub const FleetSpotMaintenanceStrategiesRequest = struct {
    /// The strategy to use when Amazon EC2 emits a signal that your Spot Instance
    /// is at an
    /// elevated risk of being interrupted.
    capacity_rebalance: ?FleetSpotCapacityRebalanceRequest,
};
