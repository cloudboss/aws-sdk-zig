pub const FindingType = enum {
    valid,
    invalid,
    not_translatable,
    allow_all,
    allow_none,
    deny_all,
    deny_none,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .not_translatable = "NOT_TRANSLATABLE",
        .allow_all = "ALLOW_ALL",
        .allow_none = "ALLOW_NONE",
        .deny_all = "DENY_ALL",
        .deny_none = "DENY_NONE",
    };
};
