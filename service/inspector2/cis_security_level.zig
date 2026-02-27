pub const CisSecurityLevel = enum {
    level_1,
    level_2,

    pub const json_field_names = .{
        .level_1 = "LEVEL_1",
        .level_2 = "LEVEL_2",
    };
};
