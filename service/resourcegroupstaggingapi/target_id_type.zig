pub const TargetIdType = enum {
    account,
    ou,
    root,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .ou = "OU",
        .root = "ROOT",
    };
};
