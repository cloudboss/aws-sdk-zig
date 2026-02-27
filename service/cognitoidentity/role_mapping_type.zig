pub const RoleMappingType = enum {
    token,
    rules,

    pub const json_field_names = .{
        .token = "TOKEN",
        .rules = "RULES",
    };
};
