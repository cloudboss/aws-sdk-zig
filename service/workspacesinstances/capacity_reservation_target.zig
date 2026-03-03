/// Identifies a specific capacity reservation.
pub const CapacityReservationTarget = struct {
    /// Unique identifier for the capacity reservation.
    capacity_reservation_id: ?[]const u8 = null,

    /// ARN of the capacity reservation resource group.
    capacity_reservation_resource_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_reservation_id = "CapacityReservationId",
        .capacity_reservation_resource_group_arn = "CapacityReservationResourceGroupArn",
    };
};
