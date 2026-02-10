const FleetReplacementStrategy = @import("fleet_replacement_strategy.zig").FleetReplacementStrategy;

/// The strategy to use when Amazon EC2 emits a signal that your Spot Instance
/// is at an
/// elevated risk of being interrupted.
pub const FleetSpotCapacityRebalance = struct {
    /// The replacement strategy to use. Only available for fleets of type
    /// `maintain`.
    ///
    /// `launch` - EC2 Fleet launches a new replacement Spot Instance when a
    /// rebalance notification is emitted for an existing Spot Instance in the
    /// fleet. EC2 Fleet
    /// does not terminate the instances that receive a rebalance notification. You
    /// can terminate
    /// the old instances, or you can leave them running. You are charged for all
    /// instances while
    /// they are running.
    ///
    /// `launch-before-terminate` - EC2 Fleet launches a new replacement Spot
    /// Instance when a rebalance notification is emitted for an existing Spot
    /// Instance in the
    /// fleet, and then, after a delay that you specify (in `TerminationDelay`),
    /// terminates the instances that received a rebalance notification.
    replacement_strategy: ?FleetReplacementStrategy,

    /// The amount of time (in seconds) that Amazon EC2 waits before terminating the
    /// old Spot
    /// Instance after launching a new replacement Spot Instance.
    ///
    /// Required when `ReplacementStrategy` is set to `launch-before-terminate`.
    ///
    /// Not valid when `ReplacementStrategy` is set to `launch`.
    ///
    /// Valid values: Minimum value of `120` seconds. Maximum value of `7200`
    /// seconds.
    termination_delay: ?i32,
};
