const ReservedCapacityAllocationStrategy = @import("reserved_capacity_allocation_strategy.zig").ReservedCapacityAllocationStrategy;
const FleetCapacityReservationTargetRequest = @import("fleet_capacity_reservation_target_request.zig").FleetCapacityReservationTargetRequest;
const FleetReservationType = @import("fleet_reservation_type.zig").FleetReservationType;
const ReservedCapacityFallbackOptionsRequest = @import("reserved_capacity_fallback_options_request.zig").ReservedCapacityFallbackOptionsRequest;

/// Defines EC2 Fleet preferences for utilizing reserved capacity when
/// `DefaultTargetCapacityType`
/// is set to `reserved-capacity`. EC2 Fleet can fulfill reserved capacity using
/// On-Demand Capacity Reservations,
/// Capacity Blocks for ML, and interruptible Capacity Reservations.
///
/// This configuration can only be used if the EC2 Fleet is of type
/// `instant`.
///
/// When you specify `ReservedCapacityOptions`, you must also set
/// `DefaultTargetCapacityType` to `reserved-capacity` in the
/// `TargetCapacitySpecification`.
///
/// For more information about interruptible Capacity Reservations, see [Launch
/// instances into an interruptible Capacity
/// Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-launch-instances-interruptible-cr-walkthrough.html) in the *Amazon EC2 User Guide*.
pub const ReservedCapacityOptionsRequest = struct {
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

    /// The Capacity Reservations or Capacity Reservation Resource Groups to use for
    /// fulfilling the EC2 Fleet
    /// request. You can specify Capacity Reservation IDs or a Capacity Reservation
    /// Resource Group
    /// ARN, but not both.
    capacity_reservation_target: ?FleetCapacityReservationTargetRequest = null,

    /// The types of Capacity Reservations to use for fulfilling the EC2 Fleet
    /// request. This is an
    /// ordered list: EC2 Fleet attempts to launch instances into each Capacity
    /// Reservation type in the order
    /// that you specify them before moving on to the next type.
    reservation_types: ?[]const FleetReservationType = null,

    /// The fallback behavior for the EC2 Fleet when there is not enough reserved
    /// capacity available
    /// to meet the target capacity. This member takes a
    /// `ReservedCapacityFallbackOptionsRequest` structure, in which you set
    /// `MarketTypes` to the instance purchasing options to fall back to.
    reserved_capacity_fallback_options: ?ReservedCapacityFallbackOptionsRequest = null,
};
