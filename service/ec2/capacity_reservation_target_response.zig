/// Describes a target Capacity Reservation or Capacity Reservation group.
pub const CapacityReservationTargetResponse = struct {
    /// The ID of the targeted Capacity Reservation.
    capacity_reservation_id: ?[]const u8,

    /// The ARN of the targeted Capacity Reservation group.
    capacity_reservation_resource_group_arn: ?[]const u8,
};
