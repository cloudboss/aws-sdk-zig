const ReservedCapacityAllocationStrategy = @import("reserved_capacity_allocation_strategy.zig").ReservedCapacityAllocationStrategy;
const FleetReservationType = @import("fleet_reservation_type.zig").FleetReservationType;
const ReservedCapacityFallbackOptions = @import("reserved_capacity_fallback_options.zig").ReservedCapacityFallbackOptions;

/// Defines EC2 Fleet preferences for utilizing reserved capacity when
/// `DefaultTargetCapacityType`
/// is set to `reserved-capacity`. EC2 Fleet can fulfill reserved capacity using
/// On-Demand Capacity Reservations,
/// Capacity Blocks for ML, and interruptible Capacity Reservations.
pub const ReservedCapacityOptions = struct {
    /// The strategy that determines the order in which EC2 Fleet launches instances
    /// across the
    /// reservation types that you specify. The only supported value is
    /// `prioritized`,
    /// which launches instances in the priority order that you specify in your
    /// launch template
    /// overrides. If you don't specify an allocation strategy, instances are
    /// launched in a
    /// random order.
    allocation_strategy: ?ReservedCapacityAllocationStrategy = null,

    /// The types of Capacity Reservations used for fulfilling the EC2 Fleet
    /// request.
    reservation_types: ?[]const FleetReservationType = null,

    /// The fallback behavior for the EC2 Fleet when there is not enough reserved
    /// capacity available
    /// to meet the target capacity.
    reserved_capacity_fallback_options: ?ReservedCapacityFallbackOptions = null,
};
