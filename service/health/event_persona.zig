pub const EventPersona = enum {
    operations,
    security,
    billing,

    pub const json_field_names = .{
        .operations = "OPERATIONS",
        .security = "SECURITY",
        .billing = "BILLING",
    };
};
