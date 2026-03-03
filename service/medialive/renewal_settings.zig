const ReservationAutomaticRenewal = @import("reservation_automatic_renewal.zig").ReservationAutomaticRenewal;

/// The Renewal settings for Reservations
pub const RenewalSettings = struct {
    /// Automatic renewal status for the reservation
    automatic_renewal: ?ReservationAutomaticRenewal = null,

    /// Count for the reservation renewal
    renewal_count: ?i32 = null,

    pub const json_field_names = .{
        .automatic_renewal = "AutomaticRenewal",
        .renewal_count = "RenewalCount",
    };
};
