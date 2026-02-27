pub const ProtectionPolicy = enum {
    no_protection,
    full_protection,

    pub const json_field_names = .{
        .no_protection = "NoProtection",
        .full_protection = "FullProtection",
    };
};
