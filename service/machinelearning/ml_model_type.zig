pub const MLModelType = enum {
    regression,
    binary,
    multiclass,

    pub const json_field_names = .{
        .regression = "REGRESSION",
        .binary = "BINARY",
        .multiclass = "MULTICLASS",
    };
};
