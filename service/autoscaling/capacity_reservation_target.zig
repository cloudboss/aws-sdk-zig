/// The target for the Capacity Reservation. Specify Capacity Reservations IDs
/// or Capacity Reservation resource group ARNs.
pub const CapacityReservationTarget = struct {
    /// The Capacity Reservation IDs to launch instances into.
    capacity_reservation_ids: ?[]const []const u8 = null,

    /// The resource group ARNs of the Capacity Reservation to launch instances
    /// into.
    capacity_reservation_resource_group_arns: ?[]const []const u8 = null,
};
