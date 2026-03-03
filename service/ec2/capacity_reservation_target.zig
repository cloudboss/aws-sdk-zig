/// Describes a target Capacity Reservation or Capacity Reservation group.
pub const CapacityReservationTarget = struct {
    /// The ID of the Capacity Reservation in which to run the instance.
    capacity_reservation_id: ?[]const u8 = null,

    /// The ARN of the Capacity Reservation resource group in which to run the
    /// instance.
    capacity_reservation_resource_group_arn: ?[]const u8 = null,
};
