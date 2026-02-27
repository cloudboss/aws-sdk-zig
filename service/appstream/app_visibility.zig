pub const AppVisibility = enum {
    all,
    associated,

    pub const json_field_names = .{
        .all = "ALL",
        .associated = "ASSOCIATED",
    };
};
