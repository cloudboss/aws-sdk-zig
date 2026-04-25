const FleetReservationType = @import("fleet_reservation_type.zig").FleetReservationType;

/// Defines EC2 Fleet preferences for utilizing reserved capacity when
/// DefaultTargetCapacityType is set to `reserved-capacity`.
pub const ReservedCapacityOptions = struct {
    /// The types of Capacity Reservations used for fulfilling the EC2 Fleet
    /// request.
    reservation_types: ?[]const FleetReservationType = null,
};
