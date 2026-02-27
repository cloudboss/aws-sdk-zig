pub const ReleaseStatusValues = enum {
    beta,
    prod,

    pub const json_field_names = .{
        .beta = "BETA",
        .prod = "PROD",
    };
};
