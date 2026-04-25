const FleetReservationType = @import("fleet_reservation_type.zig").FleetReservationType;

/// Defines EC2 Fleet preferences for utilizing reserved capacity when
/// DefaultTargetCapacityType is set to `reserved-capacity`.
///
/// This configuration can only be used if the EC2 Fleet is of type
/// `instant`.
///
/// When you specify `ReservedCapacityOptions`, you must also set
/// `DefaultTargetCapacityType` to `reserved-capacity` in the
/// `TargetCapacitySpecification`.
///
/// For more information about Interruptible Capacity Reservations, see [Launch
/// instances into an Interruptible Capacity
/// Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-launch-instances-interruptible-cr-walkthrough.html) in the *Amazon EC2 User Guide*.
pub const ReservedCapacityOptionsRequest = struct {
    /// The types of Capacity Reservations to use for fulfilling the EC2 Fleet
    /// request.
    reservation_types: ?[]const FleetReservationType = null,
};
