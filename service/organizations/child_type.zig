pub const ChildType = enum {
    account,
    organizational_unit,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
    };
};
