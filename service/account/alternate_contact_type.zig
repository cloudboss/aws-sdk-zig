pub const AlternateContactType = enum {
    billing,
    operations,
    security,

    pub const json_field_names = .{
        .billing = "BILLING",
        .operations = "OPERATIONS",
        .security = "SECURITY",
    };
};
