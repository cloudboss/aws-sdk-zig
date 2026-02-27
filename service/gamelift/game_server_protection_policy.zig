pub const GameServerProtectionPolicy = enum {
    no_protection,
    full_protection,

    pub const json_field_names = .{
        .no_protection = "NO_PROTECTION",
        .full_protection = "FULL_PROTECTION",
    };
};
