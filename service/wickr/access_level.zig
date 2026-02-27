pub const AccessLevel = enum {
    standard,
    premium,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .premium = "PREMIUM",
    };
};
