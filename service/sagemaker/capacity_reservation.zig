const CapacityReservationType = @import("capacity_reservation_type.zig").CapacityReservationType;

/// Information about the Capacity Reservation used by an instance or instance
/// group.
pub const CapacityReservation = struct {
    /// The Amazon Resource Name (ARN) of the Capacity Reservation.
    arn: ?[]const u8,

    /// The type of Capacity Reservation. Valid values are `ODCR` (On-Demand
    /// Capacity Reservation) or `CRG` (Capacity Reservation Group).
    @"type": ?CapacityReservationType,

    pub const json_field_names = .{
        .arn = "Arn",
        .@"type" = "Type",
    };
};
