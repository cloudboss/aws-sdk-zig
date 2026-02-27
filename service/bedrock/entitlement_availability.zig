pub const EntitlementAvailability = enum {
    available,
    not_available,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .not_available = "NOT_AVAILABLE",
    };
};
