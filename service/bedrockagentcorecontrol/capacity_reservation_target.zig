/// Information about the target Capacity Reservation or Capacity Reservation
/// group for the instances.
pub const CapacityReservationTarget = struct {
    /// The ID of the Capacity Reservation in which to run the instances.
    capacity_reservation_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Capacity Reservation resource group in
    /// which to run the instances.
    capacity_reservation_resource_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_reservation_id = "capacityReservationId",
        .capacity_reservation_resource_group_arn = "capacityReservationResourceGroupArn",
    };
};
