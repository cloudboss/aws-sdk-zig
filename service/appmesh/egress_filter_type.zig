pub const EgressFilterType = enum {
    allow_all,
    drop_all,

    pub const json_field_names = .{
        .allow_all = "ALLOW_ALL",
        .drop_all = "DROP_ALL",
    };
};
