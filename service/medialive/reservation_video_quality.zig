/// Video quality, e.g. 'STANDARD' (Outputs only)
pub const ReservationVideoQuality = enum {
    standard,
    enhanced,
    premium,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .enhanced = "ENHANCED",
        .premium = "PREMIUM",
    };
};
