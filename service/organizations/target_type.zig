pub const TargetType = enum {
    account,
    organizational_unit,
    root,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
        .root = "ROOT",
    };
};
