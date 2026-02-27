/// Automatic Renewal Status for Reservation
pub const ReservationAutomaticRenewal = enum {
    disabled,
    enabled,
    unavailable,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .unavailable = "UNAVAILABLE",
    };
};
