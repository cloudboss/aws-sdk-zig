/// Describes the target Capacity Reservations or Capacity Reservation Resource
/// Groups for an EC2 Fleet
/// that launches into reserved capacity. You can specify Capacity Reservation
/// IDs or a
/// Capacity Reservation Resource Group ARN, but not both.
pub const FleetCapacityReservationTargetRequest = struct {
    /// The IDs of the Capacity Reservations in which to launch the instances.
    capacity_reservation_ids: ?[]const []const u8 = null,

    /// The ARNs of the Capacity Reservation Resource Groups in which to launch the
    /// instances.
    capacity_reservation_resource_group_arns: ?[]const []const u8 = null,
};
