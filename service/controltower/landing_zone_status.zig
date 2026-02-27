pub const LandingZoneStatus = enum {
    active,
    processing,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .processing = "PROCESSING",
        .failed = "FAILED",
    };
};
