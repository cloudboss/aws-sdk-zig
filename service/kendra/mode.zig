pub const Mode = enum {
    enabled,
    learn_only,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .learn_only = "LEARN_ONLY",
    };
};
