pub const UsageType = enum {
    compute,
    license,

    pub const json_field_names = .{
        .compute = "COMPUTE",
        .license = "LICENSE",
    };
};
