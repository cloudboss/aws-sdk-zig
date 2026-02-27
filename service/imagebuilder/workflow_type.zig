pub const WorkflowType = enum {
    build,
    @"test",
    distribution,

    pub const json_field_names = .{
        .build = "BUILD",
        .@"test" = "TEST",
        .distribution = "DISTRIBUTION",
    };
};
