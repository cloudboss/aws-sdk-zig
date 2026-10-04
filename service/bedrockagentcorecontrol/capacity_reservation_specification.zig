const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;

/// The Capacity Reservation targeting option for the instances.
pub const CapacityReservationSpecification = struct {
    /// The Capacity Reservation preference for the instances.
    capacity_reservation_preference: ?CapacityReservationPreference = null,

    /// The target Capacity Reservation or Capacity Reservation group for the
    /// instances.
    capacity_reservation_target: ?CapacityReservationTarget = null,

    pub const json_field_names = .{
        .capacity_reservation_preference = "capacityReservationPreference",
        .capacity_reservation_target = "capacityReservationTarget",
    };
};
