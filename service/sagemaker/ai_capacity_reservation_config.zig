const AICapacityReservationPreference = @import("ai_capacity_reservation_preference.zig").AICapacityReservationPreference;

/// The capacity reservation configuration for an AI recommendation job.
pub const AICapacityReservationConfig = struct {
    /// The capacity reservation preference. The only valid value is
    /// `capacity-reservations-only`.
    capacity_reservation_preference: ?AICapacityReservationPreference = null,

    /// The list of ML reservation ARNs to use.
    ml_reservation_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .capacity_reservation_preference = "CapacityReservationPreference",
        .ml_reservation_arns = "MlReservationArns",
    };
};
