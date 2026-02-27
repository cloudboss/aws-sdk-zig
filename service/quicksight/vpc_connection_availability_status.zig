pub const VPCConnectionAvailabilityStatus = enum {
    available,
    unavailable,
    partially_available,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .unavailable = "UNAVAILABLE",
        .partially_available = "PARTIALLY_AVAILABLE",
    };
};
