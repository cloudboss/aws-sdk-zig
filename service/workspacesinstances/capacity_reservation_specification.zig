const CapacityReservationPreferenceEnum = @import("capacity_reservation_preference_enum.zig").CapacityReservationPreferenceEnum;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;

/// Specifies capacity reservation preferences.
pub const CapacityReservationSpecification = struct {
    /// Preference for using capacity reservation.
    capacity_reservation_preference: ?CapacityReservationPreferenceEnum = null,

    /// Specific capacity reservation target.
    capacity_reservation_target: ?CapacityReservationTarget = null,

    pub const json_field_names = .{
        .capacity_reservation_preference = "CapacityReservationPreference",
        .capacity_reservation_target = "CapacityReservationTarget",
    };
};
