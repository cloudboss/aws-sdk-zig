pub const ComponentType = enum {
    build,
    @"test",

    pub const json_field_names = .{
        .build = "BUILD",
        .@"test" = "TEST",
    };
};
