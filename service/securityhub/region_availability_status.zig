pub const RegionAvailabilityStatus = enum {
    available,
    unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .unavailable = "UNAVAILABLE",
    };
};
