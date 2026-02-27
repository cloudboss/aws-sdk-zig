pub const TierLevel = enum {
    basic,
    standard,

    pub const json_field_names = .{
        .basic = "BASIC",
        .standard = "STANDARD",
    };
};
